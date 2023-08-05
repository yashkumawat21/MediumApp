import "./post.css";
import { Users } from "../../dummyData";
import { useState } from "react";

export default function Post({ post }) {
  const [like, setLike] = useState(post.like);
  const [isLiked, setIsLiked] = useState(false);
  const [comments, setComments] = useState(post.comments || []);
  const [newComment, setNewComment] = useState("");
  const [isSaved, setIsSaved] = useState(false);

  const likeHandler = () => {
    setLike((prevLike) => prevLike + 1);
    setIsLiked(!isLiked);
  };

  const handleCommentSubmit = (e) => {
    e.preventDefault();
    if (newComment.trim() !== "") {
      setComments((prevComments) => [
        ...prevComments,
        { id: Date.now(), text: newComment },
      ]);
      setNewComment("");
    }
  };

  const handleSaveForLater = () => {
    setIsSaved(!isSaved);
  };

  return (
    <div className="post">
      <div className="postWrapper">
        <div className="postTitle">
          <h2>{post?.title}</h2>
        </div>
        <div className="postHeading">
          <h3>{post?.heading}</h3>
        </div>
        <div className="postTop">
          <div className="postTopLeft">
            <img
              className="postProfileImg"
              src={Users.filter((u) => u.id === post?.userId)[0].profilePicture}
              alt=""
            />
            <span className="postUsername">
              {Users.filter((u) => u.id === post?.userId)[0].username}
            </span>
            <span className="postDate">{post.date}</span>
          </div>
          <div className="postTopRight">
            {/* Read article button */}
            <button className="readButton">Read article</button>
          </div>
        </div>
        <div className="postCenter">
          <span className="postText">{post?.desc}</span>
          <img className="postImg" src={post.photo} alt="" />
        </div>
        <div className="postBottom">
          <div className="postBottomLeft">
            <button className="likeButton" onClick={likeHandler}>
              {isLiked ? `${like} Likes` : `${like} Like`}
            </button>
          </div>
          <div className="postComments">
            {comments.map((comment) => (
              <div key={comment.id} className="comment">
                <span className="commentText">{comment.text}</span>
              </div>
            ))}
            <form className="commentForm" onSubmit={handleCommentSubmit}>
              <input
                type="text"
                placeholder="Add comment"
                value={newComment}
                onChange={(e) => setNewComment(e.target.value)}
              />
              <button type="submit">Post</button>
            </form>
          </div>
          <div className="postBottomRight">
            <button className="saveButton" onClick={handleSaveForLater}>
              {isSaved ? "Saved" : "Save for Later"}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}