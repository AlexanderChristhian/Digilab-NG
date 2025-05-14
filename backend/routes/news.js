const express = require('express');
const multer = require('multer');
const { authenticate, authorize } = require('../middleware/auth');
const { uploadFile } = require('../config/cloudinary');
const db = require('../db');

const router = express.Router();

// Configure multer for file uploads
const upload = multer({ dest: 'uploads/' });

// Get all news
router.get('/', async (req, res) => {
  try {
    const result = await db.query(`
      SELECT n.*, u.username as author, 
             c.title as class_title, c.id as class_id,
             m.title as module_title, m.id as module_id,
             a.title as assignment_title, a.id as assignment_id
      FROM news n
      JOIN users u ON n.created_by = u.id
      LEFT JOIN classes c ON n.linked_type = 'class' AND n.linked_id = c.id
      LEFT JOIN modules m ON n.linked_type = 'module' AND n.linked_id = m.id
      LEFT JOIN assignments a ON n.linked_type = 'assignment' AND n.linked_id = a.id
      ORDER BY n.created_at DESC
    `);

    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get a news item by ID
router.get('/:id', async (req, res) => {
  try {
    const result = await db.query(`
      SELECT n.*, u.username as author,
             c.title as class_title, c.id as class_id,
             m.title as module_title, m.id as module_id,
             a.title as assignment_title, a.id as assignment_id
      FROM news n
      JOIN users u ON n.created_by = u.id
      LEFT JOIN classes c ON n.linked_type = 'class' AND n.linked_id = c.id
      LEFT JOIN modules m ON n.linked_type = 'module' AND n.linked_id = m.id
      LEFT JOIN assignments a ON n.linked_type = 'assignment' AND n.linked_id = a.id
      WHERE n.id = $1
    `, [req.params.id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'News not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get news for a specific linked entity (class, module, or assignment)
router.get('/for/:type/:id', async (req, res) => {
  try {
    const { type, id } = req.params;
    
    if (!['class', 'module', 'assignment'].includes(type)) {
      return res.status(400).json({ message: 'Invalid entity type' });
    }

    const result = await db.query(`
      SELECT n.*, u.username as author
      FROM news n
      JOIN users u ON n.created_by = u.id
      WHERE n.linked_type = $1 AND n.linked_id = $2
      ORDER BY n.created_at DESC
    `, [type, id]);

    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching linked news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Create a news item (aslab only)
router.post('/', authenticate, authorize(['aslab']), upload.single('image'), async (req, res) => {
  try {
    const { title, content, linkedType, linkedId } = req.body;
    const file = req.file;

    if (!title || !content) {
      return res.status(400).json({ message: 'Title and content are required' });
    }

    // Validate linked entity if provided
    if (linkedType && !['class', 'module', 'assignment'].includes(linkedType)) {
      return res.status(400).json({ message: 'Invalid linked entity type' });
    }

    // If linkedType is provided, verify that the linked entity exists
    if (linkedType && linkedId) {
      let table = '';
      switch (linkedType) {
        case 'class': table = 'classes'; break;
        case 'module': table = 'modules'; break;
        case 'assignment': table = 'assignments'; break;
      }

      const entityExists = await db.query(`SELECT id FROM ${table} WHERE id = $1`, [linkedId]);
      if (entityExists.rows.length === 0) {
        return res.status(404).json({ message: `${linkedType.charAt(0).toUpperCase() + linkedType.slice(1)} not found` });
      }
    }

    let imageUrl = null;
    if (file) {
      const uploadResult = await uploadFile(file, 'news');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'INSERT INTO news (title, content, image_url, created_by, linked_type, linked_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [title, content, imageUrl, req.user.id, linkedType || null, linkedId || null]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const news = result.rows[0];
    news.author = userResult.rows[0].username;

    // Get linked entity details if applicable
    if (linkedType && linkedId) {
      let linkedEntityResult;
      switch (linkedType) {
        case 'class':
          linkedEntityResult = await db.query('SELECT title FROM classes WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.class_title = linkedEntityResult.rows[0].title;
            news.class_id = parseInt(linkedId);
          }
          break;
        case 'module':
          linkedEntityResult = await db.query('SELECT title FROM modules WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.module_title = linkedEntityResult.rows[0].title;
            news.module_id = parseInt(linkedId);
          }
          break;
        case 'assignment':
          linkedEntityResult = await db.query('SELECT title FROM assignments WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.assignment_title = linkedEntityResult.rows[0].title;
            news.assignment_id = parseInt(linkedId);
          }
          break;
      }
    }

    res.status(201).json(news);
  } catch (error) {
    console.error('Error creating news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Update a news item (aslab only)
router.put('/:id', authenticate, authorize(['aslab']), upload.single('image'), async (req, res) => {
  try {
    const { title, content, linkedType, linkedId } = req.body;
    const file = req.file;

    if (!title || !content) {
      return res.status(400).json({ message: 'Title and content are required' });
    }

    // Validate linked entity if provided
    if (linkedType && !['class', 'module', 'assignment'].includes(linkedType)) {
      return res.status(400).json({ message: 'Invalid linked entity type' });
    }

    // Check if news exists
    const newsCheck = await db.query('SELECT * FROM news WHERE id = $1', [req.params.id]);
    if (newsCheck.rows.length === 0) {
      return res.status(404).json({ message: 'News not found' });
    }

    // Only allow the creator or an aslab to update
    if (newsCheck.rows[0].created_by !== req.user.id && req.user.role !== 'aslab') {
      return res.status(403).json({ message: 'Not authorized to update this news' });
    }

    // If linkedType is provided, verify that the linked entity exists
    if (linkedType && linkedId) {
      let table = '';
      switch (linkedType) {
        case 'class': table = 'classes'; break;
        case 'module': table = 'modules'; break;
        case 'assignment': table = 'assignments'; break;
      }

      const entityExists = await db.query(`SELECT id FROM ${table} WHERE id = $1`, [linkedId]);
      if (entityExists.rows.length === 0) {
        return res.status(404).json({ message: `${linkedType.charAt(0).toUpperCase() + linkedType.slice(1)} not found` });
      }
    }

    let imageUrl = newsCheck.rows[0].image_url;
    if (file) {
      const uploadResult = await uploadFile(file, 'news');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'UPDATE news SET title = $1, content = $2, image_url = $3, linked_type = $4, linked_id = $5, updated_at = CURRENT_TIMESTAMP WHERE id = $6 RETURNING *',
      [title, content, imageUrl, linkedType || null, linkedId || null, req.params.id]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const news = result.rows[0];
    news.author = userResult.rows[0].username;

    // Get linked entity details if applicable
    if (linkedType && linkedId) {
      let linkedEntityResult;
      switch (linkedType) {
        case 'class':
          linkedEntityResult = await db.query('SELECT title FROM classes WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.class_title = linkedEntityResult.rows[0].title;
            news.class_id = parseInt(linkedId);
          }
          break;
        case 'module':
          linkedEntityResult = await db.query('SELECT title FROM modules WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.module_title = linkedEntityResult.rows[0].title;
            news.module_id = parseInt(linkedId);
          }
          break;
        case 'assignment':
          linkedEntityResult = await db.query('SELECT title FROM assignments WHERE id = $1', [linkedId]);
          if (linkedEntityResult.rows.length > 0) {
            news.assignment_title = linkedEntityResult.rows[0].title;
            news.assignment_id = parseInt(linkedId);
          }
          break;
      }
    }

    res.json(news);
  } catch (error) {
    console.error('Error updating news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Delete a news item (aslab only)
router.delete('/:id', authenticate, authorize(['aslab']), async (req, res) => {
  try {
    // Check if news exists
    const newsCheck = await db.query('SELECT * FROM news WHERE id = $1', [req.params.id]);
    if (newsCheck.rows.length === 0) {
      return res.status(404).json({ message: 'News not found' });
    }

    // Only allow the creator or an aslab to delete
    if (newsCheck.rows[0].created_by !== req.user.id && req.user.role !== 'aslab') {
      return res.status(403).json({ message: 'Not authorized to delete this news' });
    }

    await db.query('DELETE FROM news WHERE id = $1', [req.params.id]);

    res.json({ message: 'News deleted successfully' });
  } catch (error) {
    console.error('Error deleting news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
