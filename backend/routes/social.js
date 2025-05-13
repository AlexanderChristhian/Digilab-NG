const express = require('express');
const multer = require('multer');
const { authenticate } = require('../middleware/auth');
const { uploadFile } = require('../config/cloudinary');
const db = require('../db');

const router = express.Router();

// Configure multer for file uploads
const upload = multer({ dest: 'uploads/' });

// Get all posts
router.get('/posts', async (req, res) => {
  try {
    const result = await db.query(`
      SELECT p.*, u.username, 
        (SELECT COUNT(*) FROM comments WHERE post_id = p.id) as comment_count
      FROM posts p
      JOIN users u ON p.user_id = u.id
      ORDER BY p.created_at DESC
    `);

    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching posts:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get a post by ID with comments
router.get('/posts/:id', async (req, res) => {
  try {
    // Get post
    const postResult = await db.query(`
      SELECT p.*, u.username
      FROM posts p
      JOIN users u ON p.user_id = u.id
      WHERE p.id = $1
    `, [req.params.id]);

    if (postResult.rows.length === 0) {
      return res.status(404).json({ message: 'Post not found' });
    }

    // Get comments
    const commentsResult = await db.query(`
      SELECT c.*, u.username
      FROM comments c
      JOIN users u ON c.user_id = u.id
      WHERE c.post_id = $1
      ORDER BY c.created_at ASC
    `, [req.params.id]);

    const post = postResult.rows[0];
    post.comments = commentsResult.rows;

    res.json(post);
  } catch (error) {
    console.error('Error fetching post:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Create a new post
router.post('/posts', authenticate, upload.single('image'), async (req, res) => {
  try {
    const { content } = req.body;
    const file = req.file;

    if (!content) {
      return res.status(400).json({ message: 'Content is required' });
    }

    let imageUrl = null;
    if (file) {
      const uploadResult = await uploadFile(file, 'posts');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'INSERT INTO posts (user_id, content, image_url) VALUES ($1, $2, $3) RETURNING *',
      [req.user.id, content, imageUrl]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const post = result.rows[0];
    post.username = userResult.rows[0].username;
    post.comment_count = 0;

    res.status(201).json(post);
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Update a post
router.put('/posts/:id', authenticate, upload.single('image'), async (req, res) => {
  try {
    const { content } = req.body;
    const file = req.file;

    if (!content) {
      return res.status(400).json({ message: 'Content is required' });
    }

    // Check if post exists and user is the creator
    const postCheck = await db.query(
      'SELECT * FROM posts WHERE id = $1',
      [req.params.id]
    );

    if (postCheck.rows.length === 0) {
      return res.status(404).json({ message: 'Post not found' });
    }

    if (postCheck.rows[0].user_id !== req.user.id) {
      return res.status(403).json({ message: 'Not authorized to update this post' });
    }

    let imageUrl = postCheck.rows[0].image_url;
    if (file) {
      const uploadResult = await uploadFile(file, 'posts');
      imageUrl = uploadResult.url;
    }

    const result = await db.query(
      'UPDATE posts SET content = $1, image_url = $2, updated_at = CURRENT_TIMESTAMP WHERE id = $3 RETURNING *',
      [content, imageUrl, req.params.id]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const post = result.rows[0];
    post.username = userResult.rows[0].username;

    res.json(post);
  } catch (error) {
    console.error('Error updating post:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Delete a post
router.delete('/posts/:id', authenticate, async (req, res) => {
  try {
    // Check if post exists and user is the creator
    const postCheck = await db.query(
      'SELECT * FROM posts WHERE id = $1',
      [req.params.id]
    );

    if (postCheck.rows.length === 0) {
      return res.status(404).json({ message: 'Post not found' });
    }

    if (postCheck.rows[0].user_id !== req.user.id) {
      return res.status(403).json({ message: 'Not authorized to delete this post' });
    }

    await db.query('DELETE FROM posts WHERE id = $1', [req.params.id]);

    res.json({ message: 'Post deleted successfully' });
  } catch (error) {
    console.error('Error deleting post:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Add a comment to a post
router.post('/posts/:id/comments', authenticate, async (req, res) => {
  try {
    const { content } = req.body;

    if (!content) {
      return res.status(400).json({ message: 'Content is required' });
    }

    // Check if post exists
    const postCheck = await db.query('SELECT * FROM posts WHERE id = $1', [req.params.id]);
    if (postCheck.rows.length === 0) {
      return res.status(404).json({ message: 'Post not found' });
    }

    const result = await db.query(
      'INSERT INTO comments (post_id, user_id, content) VALUES ($1, $2, $3) RETURNING *',
      [req.params.id, req.user.id, content]
    );

    // Get username for response
    const userResult = await db.query('SELECT username FROM users WHERE id = $1', [req.user.id]);
    const comment = result.rows[0];
    comment.username = userResult.rows[0].username;

    res.status(201).json(comment);
  } catch (error) {
    console.error('Error creating comment:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Delete a comment
router.delete('/comments/:id', authenticate, async (req, res) => {
  try {
    // Check if comment exists and user is the creator
    const commentCheck = await db.query(
      'SELECT * FROM comments WHERE id = $1',
      [req.params.id]
    );

    if (commentCheck.rows.length === 0) {
      return res.status(404).json({ message: 'Comment not found' });
    }

    if (commentCheck.rows[0].user_id !== req.user.id) {
      return res.status(403).json({ message: 'Not authorized to delete this comment' });
    }

    await db.query('DELETE FROM comments WHERE id = $1', [req.params.id]);

    res.json({ message: 'Comment deleted successfully' });
  } catch (error) {
    console.error('Error deleting comment:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
