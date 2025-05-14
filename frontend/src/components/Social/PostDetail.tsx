import { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import axios from 'axios';
import { format } from 'date-fns';
import { useAuth } from '../../context/AuthContext';
import PostForm from './PostForm.tsx';
import CommentList from './CommentList';
import CommentForm from './CommentForm';

// API URL from environment
const API_URL = import.meta.env.VITE_API_URL || '/api';

const PostDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  
  const [post, setPost] = useState<any>(null);
  const [comments, setComments] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [isEditing, setIsEditing] = useState(false);

  useEffect(() => {
    const fetchPostDetails = async () => {
      try {
        setLoading(true);
        const response = await axios.get(`${API_URL}/social/posts/${id}`);
        setPost(response.data);
        setComments(response.data.comments || []);
      } catch (err) {
        console.error('Error fetching post details:', err);
        setError('Failed to load post');
      } finally {
        setLoading(false);
      }
    };
    
    if (id) {
      fetchPostDetails();
    }
  }, [id]);

  const handleDeletePost = async () => {
    if (!window.confirm('Are you sure you want to delete this post?')) {
      return;
    }
    
    try {
      await axios.delete(`${API_URL}/social/posts/${id}`);
      navigate('/social');
    } catch (err) {
      console.error('Error deleting post:', err);
      setError('Failed to delete post');
    }
  };

  const handlePostUpdated = async () => {
    setIsEditing(false);
    
    // Refresh post data
    try {
      const response = await axios.get(`${API_URL}/social/posts/${id}`);
      setPost(response.data);
    } catch (err) {
      console.error('Error refreshing post data:', err);
    }
  };

  const handleCommentAdded = (newComment: any) => {
    setComments([...comments, newComment]);
  };

  const handleCommentDeleted = (commentId: number) => {
    setComments(comments.filter(comment => comment.id !== commentId));
  };

  if (loading) {
    return (
      <div className="container-custom py-8">
        <div className="flex justify-center items-center my-10">
          <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500"></div>
        </div>
      </div>
    );
  }

  if (error || !post) {
    return (
      <div className="container-custom py-8">
        <div className="max-w-3xl mx-auto">
          <div className="bg-red-50 dark:bg-red-900/20 border border-red-400 dark:border-red-800 text-red-700 dark:text-red-400 px-4 py-3 rounded-lg mb-4">
            <p>{error || 'Post not found'}</p>
          </div>
          <div className="mt-4">
            <Link 
              to="/social" 
              className="text-primary-600 dark:text-primary-400 hover:text-primary-700 hover:underline"
            >
              &larr; Back to Social
            </Link>
          </div>
        </div>
      </div>
    );
  }

  const isOwnPost = user?.id === post.user_id;
  const formattedDate = format(new Date(post.created_at), 'MMMM d, yyyy');

  return (
    <div className="container-custom py-8">
      <div className="max-w-3xl mx-auto">
        <div className="mb-4">
          <Link 
            to="/social" 
            className="text-primary-600 dark:text-primary-400 hover:text-primary-700 hover:underline"
          >
            &larr; Back to Social
          </Link>
        </div>

        <div className="bg-white dark:bg-gradient-to-r dark:from-gray-800 dark:to-gray-700 rounded-lg shadow-md overflow-hidden">
          {isEditing ? (
            <div className="p-4">
              <PostForm 
                post={post}
                isEditing={true}
                onPostUpdated={handlePostUpdated}
                onCancel={() => setIsEditing(false)}
              />
            </div>
          ) : (
            <>
              <div className="p-4">
                <div className="flex items-start justify-between mb-4">
                  <div className="flex items-center">
                    <div className="h-12 w-12 rounded-full bg-primary-100 dark:bg-primary-900 flex items-center justify-center text-primary-700 dark:text-primary-300 font-bold text-lg">
                      {post.username.charAt(0).toUpperCase()}
                    </div>
                    <div className="ml-3">
                      <p className="font-medium text-secondary-900 dark:text-dark-text">
                        {post.username}
                      </p>
                      <p className="text-xs text-secondary-500 dark:text-dark-muted">
                        Posted on {formattedDate}
                        {post.updated_at !== post.created_at && ' (edited)'}
                      </p>
                    </div>
                  </div>
                  
                  {isOwnPost && (
                    <div className="space-x-2">
                      <button
                        onClick={() => setIsEditing(true)}
                        className="px-3 py-1 text-sm bg-primary-600 text-white rounded hover:bg-primary-700"
                      >
                        Edit
                      </button>
                      <button
                        onClick={handleDeletePost}
                        className="px-3 py-1 text-sm bg-red-600 text-white rounded hover:bg-red-700"
                      >
                        Delete
                      </button>
                    </div>
                  )}
                </div>
                
                <div className="mb-4">
                  <p className="text-secondary-900 dark:text-dark-text text-lg whitespace-pre-line">
                    {post.content}
                  </p>
                </div>
                
                {post.image_url && (
                  <div className="mb-4">
                    <img
                      src={post.image_url}
                      alt="Post attachment"
                      className="w-full h-auto rounded-lg max-h-96 object-cover"
                    />
                  </div>
                )}
              </div>
              
              <div className="bg-gray-50 dark:bg-gray-800/50 p-4 border-t border-gray-200 dark:border-gray-700">
                <h3 className="font-medium text-secondary-900 dark:text-dark-text mb-4">
                  {comments.length} {comments.length === 1 ? 'Comment' : 'Comments'}
                </h3>
                
                <CommentList 
                  comments={comments} 
                  postId={parseInt(id as string)} 
                  onCommentDeleted={handleCommentDeleted}
                />
                
                {user && (
                  <div className="mt-4">
                    <CommentForm 
                      postId={parseInt(id as string)}
                      onCommentAdded={handleCommentAdded}
                    />
                  </div>
                )}
                
                {!user && (
                  <div className="mt-4 p-3 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-300 dark:border-yellow-800 rounded-md text-sm text-yellow-700 dark:text-yellow-400">
                    <p>Please log in to add a comment.</p>
                  </div>
                )}
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default PostDetail;
