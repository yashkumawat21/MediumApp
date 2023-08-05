import React, { useState, useEffect } from "react";
import "./share.css";
import { PermMedia, Label } from "@material-ui/icons";

export default function Share() {
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [authorName, setAuthorName] = useState("");
  const [sharedPosts, setSharedPosts] = useState([]);
  const [tagClicked, setTagClicked] = useState(false);
  const [showPost, setShowPost] = useState(false);
  const [editingPostId, setEditingPostId] = useState(null);
  const [editingTitle, setEditingTitle] = useState("");
  const [editingContent, setEditingContent] = useState("");
  const [likeCounts, setLikeCounts] = useState({});
  const [revenueCounts, setRevenueCounts] = useState({});

  useEffect(() => {
    const savedLikeCounts = JSON.parse(localStorage.getItem("likeCounts")) || {};
    const savedRevenueCounts = JSON.parse(localStorage.getItem("revenueCounts")) || {};
    setLikeCounts(savedLikeCounts);
    setRevenueCounts(savedRevenueCounts);

    const savedPosts = JSON.parse(localStorage.getItem("savedPosts"));
    if (savedPosts) {
      setSharedPosts(savedPosts);
    }
  }, []);

  const handleShare = () => {
    const newPost = {
      id: Date.now(),
      title,
      content,
      authorName,
      date: new Date().toLocaleString(),
    };
    const updatedPosts = [...sharedPosts, newPost];
    setSharedPosts(updatedPosts);
    localStorage.setItem("savedPosts", JSON.stringify(updatedPosts));

    // Clear the input fields after sharing
    setTitle("");
    setContent("");
    setAuthorName("");
    setShowPost(true);
  };

  const handleTagClick = () => {
    setTagClicked(true);
    setContent((prevContent) => (prevContent ? "#" + prevContent : "#"));
  };

  const handleEdit = (postId) => {
    const postToEdit = sharedPosts.find((post) => post.id === postId);
    setEditingPostId(postId);
    setEditingTitle(postToEdit.title);
    setEditingContent(postToEdit.content);
  };

  const handleSave = () => {
    const updatedPosts = sharedPosts.map((post) => {
      if (post.id === editingPostId) {
        return {
          ...post,
          title: editingTitle,
          content: editingContent,
        };
      }
      return post;
    });
    setSharedPosts(updatedPosts);
    localStorage.setItem("savedPosts", JSON.stringify(updatedPosts));
    setEditingPostId(null);
    setEditingTitle("");
    setEditingContent("");
  };

  const handleCancelEdit = () => {
    setEditingPostId(null);
    setEditingTitle("");
    setEditingContent("");
  };

  const handleDelete = (postId) => {
    const updatedPosts = sharedPosts.filter((post) => post.id !== postId);
    setSharedPosts(updatedPosts);
    localStorage.setItem("savedPosts", JSON.stringify(updatedPosts));
  };

  const handleLike = (postId) => {
    setLikeCounts((prevCounts) => ({
      ...prevCounts,
      [postId]: (prevCounts[postId] || 0) + 1,
    }));

    setRevenueCounts((prevCounts) => ({
      ...prevCounts,
      [postId]: Math.floor((likeCounts[postId] || 0) / 3) * 0.5,
    }));

    // Save like and revenue counts to local storage
    localStorage.setItem("likeCounts", JSON.stringify(likeCounts));
    localStorage.setItem("revenueCounts", JSON.stringify(revenueCounts));
  };

  const handleUnlike = (postId) => {
    setLikeCounts((prevCounts) => ({
      ...prevCounts,
      [postId]: Math.max((prevCounts[postId] || 0) - 1, 0),
    }));

    setRevenueCounts((prevCounts) => ({
      ...prevCounts,
      [postId]: Math.floor(Math.max((likeCounts[postId] || 0) - 1, 0) / 3) * 0.5,
    }));

    // Save like and revenue counts to local storage
    localStorage.setItem("likeCounts", JSON.stringify(likeCounts));
    localStorage.setItem("revenueCounts", JSON.stringify(revenueCounts));
  };

  return (
    <div className="share">
      <div className="shareWrapper">
        <div className="shareTop">
          <img className="shareProfileImg" src="/assets/person/1.jpeg" alt="" />
          <div className="shareInputs">
            <div className="shareInputsWrapper">
              <input
                placeholder="Enter title"
                className="shareInputTitle"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
              />
               <input
                placeholder="Enter author's name"
                className="shareInputAuthor"
                value={authorName}
                onChange={(e) => setAuthorName(e.target.value)}
              />
            </div>
            <input
              placeholder="Tell us about your day! Write an article or share a memory."
              className="shareInput"
              value={content}
              onChange={(e) => setContent(e.target.value)}
            />
          </div>
        </div>
        <hr className="shareHr" />
        <div className="shareBottom">
          <div className="shareOptions">
            <div className="shareOption">
              <PermMedia htmlColor="tomato" className="shareIcon" />
              <span className="shareOptionText">Upload Photo</span>
            </div>
            <div className="shareOption" onClick={handleTagClick}>
              <Label htmlColor="blue" className="shareIcon" />
              <span className="shareOptionText">Tag</span>
            </div>
          </div>
          <button className="shareButton" onClick={handleShare}>
            Share
          </button>
        </div>
      </div>

      {showPost && (
        <div>
          {sharedPosts.map((post) => (
            <div key={post.id} className="post">
              <div className="postWrapper">
                <div className="postActions">
                  {editingPostId === post.id ? (
                    <>
                      <button className="postButtonSave" onClick={handleSave}>
                        Save
                      </button>
                      <button
                        className="postButtonCancelEdit"
                        onClick={handleCancelEdit}
                      >
                        Cancel
                      </button>
                    </>
                  ) : (
                    <>
                      <button
                        className="postButtonEdit"
                        onClick={() => handleEdit(post.id)}
                      >
                        Edit
                      </button>
                      <button
                        className="postButtonDelete"
                        onClick={() => handleDelete(post.id)}
                      >
                        Delete
                      </button>
                      <button className="postButtonSaveLater">Save for Later</button>
                    </>
                  )}
                </div>
                <div className="postTop">
                  <img className="postProfileImg" src="/assets/person/1.jpeg" alt="" />
                  {editingPostId === post.id ? (
                    <input
                      className="postTitleEdit"
                      value={editingTitle}
                      onChange={(e) => setEditingTitle(e.target.value)}
                    />
                  ) : (
                    <div>
                      <span className="postTitle">{post.title}</span>
                      <span className="postAuthor">{post.authorName}</span>
                    </div>
                  )}
                </div>
                <div className="postContent">
                  {editingPostId === post.id ? (
                    <textarea
                      className="postContentEdit"
                      value={editingContent}
                      onChange={(e) => setEditingContent(e.target.value)}
                    />
                  ) : (
                    post.content
                  )}
                </div>
                <div className="postDate">Uploaded on {post.date}</div>
                <div className="postCounters">
                  <button className="postLikeButton" src="../assests/like.png" onClick={() => handleLike(post.id)}>
                    Like ({likeCounts[post.id] || 0})
                  </button>
                  {revenueCounts[post.id] && (
                    <span className="postRevenue">${revenueCounts[post.id]}</span>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}