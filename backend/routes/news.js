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
      SELECT n.*, u.username as author
      FROM news n
      JOIN users u ON n.created_by = u.id
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
      SELECT n.*, u.username as author
      FROM news n
      JOIN users u ON n.created_by = u.id
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

// Create a news item (aslab only)
router.post('/', authenticate, authorize(['aslab']), upload.single('image'), async (req, res) => {
  try {
    const { title, content } = req.body;
    const file = req.file;

    if (!title || !content) {
      return res.status(400).json({ message: 'Title and content are required' });
    }

    let imageUrl = null;
    if (file) {
      const uploadResult = await uploadFile(file, 'news');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'INSERT INTO news (title, content, image_url, created_by) VALUES ($1, $2, $3, $4) RETURNING *',
      [title, content, imageUrl, req.user.id]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const news = result.rows[0];
    news.author = userResult.rows[0].username;

    res.status(201).json(news);
  } catch (error) {
    console.error('Error creating news:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Update a news item (aslab only)
router.put('/:id', authenticate, authorize(['aslab']), upload.single('image'), async (req, res) => {
  try {
    const { title, content } = req.body;
    const file = req.file;

    if (!title || !content) {
      return res.status(400).json({ message: 'Title and content are required' });
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

    let imageUrl = newsCheck.rows[0].image_url;
    if (file) {
      const uploadResult = await uploadFile(file, 'news');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'UPDATE news SET title = $1, content = $2, image_url = $3, updated_at = CURRENT_TIMESTAMP WHERE id = $4 RETURNING *',
      [title, content, imageUrl, req.params.id]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const news = result.rows[0];
    news.author = userResult.rows[0].username;

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
