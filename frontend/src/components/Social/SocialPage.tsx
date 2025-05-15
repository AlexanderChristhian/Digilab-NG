import { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import PostForm from './PostForm.tsx';

// API URL from environment
const API_URL = import.meta.env.VITE_API_URL || '/api';

interface Post {
  id: number;
  content: string;
  image_url: string | null;
  created_at: string;
  updated_at: string;
  user_id: number;
  username: string;
  comment_count: number;
}

const SocialPage = () => {
  const { user } = useAuth();
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [refreshTrigger, setRefreshTrigger] = useState(0);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        setLoading(true);
        const response = await axios.get(`${API_URL}/social/posts`);
        setPosts(response.data);
      } catch (err) {
        console.error('Error fetching posts:', err);
        setError('Failed to load posts. Please try again later.');
      } finally {
        setLoading(false);
      }
    };

    fetchPosts();
  }, [refreshTrigger]);

  const handlePostCreated = () => {
    // Trigger a refresh of the posts list
    setRefreshTrigger(prev => prev + 1);
  };

  return (
    <div className="container-custom py-8">
      <div className="max-w-3xl mx-auto">
        <h1 className="text-2xl font-bold text-secondary-900 dark:text-dark-text mb-6">
          Digilab Social
        </h1>

        {error && (
          <div className="bg-red-50 dark:bg-red-900/20 border border-red-400 dark:border-red-800 text-red-700 dark:text-red-400 px-4 py-3 rounded relative mb-4" role="alert">
            <span className="block sm:inline">{error}</span>
            <button 
              className="absolute top-0 bottom-0 right-0 px-4"
              onClick={() => setError(null)}
            >
              <span className="sr-only">Dismiss</span>
              <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        )}

        {user && (
          <div className="mb-6">
            <PostForm onPostCreated={handlePostCreated} />
          </div>
        )}

        {loading ? (
          <div className="flex justify-center my-10">
            <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500"></div>
          </div>
        ) : posts.length > 0 ? (
          <div className="space-y-6">
            {posts.map(post => (
              <div key={post.id} className="bg-white dark:bg-gradient-to-r dark:from-gray-800 dark:to-gray-700 rounded-lg shadow-md p-4">
                <div className="flex items-start justify-between mb-2">
                  <div className="flex items-center">
                    <div className="h-10 w-10 rounded-full bg-primary-100 dark:bg-primary-900 flex items-center justify-center text-primary-700 dark:text-primary-300 font-bold">
                      {post.username.charAt(0).toUpperCase()}
                    </div>
                    <div className="ml-3">
                      <p className="font-medium text-secondary-900 dark:text-dark-text">
                        {post.username}
                      </p>
                    </div>
                  </div>
                </div>
                
                <div className="mb-3">
                  <p className="text-secondary-900 dark:text-dark-text whitespace-pre-line">
                    {post.content.length > 200 
                      ? `${post.content.substring(0, 200)}...` 
                      : post.content}
                  </p>
                </div>
                
                {post.image_url && (
                  <div className="mb-3">
                    <img
                      src={post.image_url}
                      alt="Post attachment"
                      className="w-full h-auto rounded-lg max-h-60 object-cover"
                    />
                  </div>
                )}
                
                <div className="mt-4 flex justify-between">
                  <div className="flex items-center text-secondary-500 dark:text-dark-muted">
                    <svg className="h-5 w-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8h2a2 2 0 012 2v6a2 2 0 01-2 2h-2v4l-4-4H9a2 2 0 01-2-2v-6a2 2 0 012-2h10z" />
                    </svg>
                    <span>{post.comment_count} {post.comment_count === 1 ? 'Comment' : 'Comments'}</span>
                  </div>
                  
                  <Link 
                    to={`/social/${post.id}`}
                    className="text-primary-600 dark:text-primary-400 hover:text-primary-700 hover:underline"
                  >
                    View Post
                  </Link>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="text-center py-8 bg-white dark:bg-gray-800 rounded-lg shadow">
            <svg className="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
            </svg>
            <h3 className="mt-2 text-lg font-medium text-gray-900 dark:text-gray-100">No posts yet</h3>
            <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Be the first to share something with the community!
            </p>
          </div>
        )}
      </div>
    </div>
  );
};

export default SocialPage;
