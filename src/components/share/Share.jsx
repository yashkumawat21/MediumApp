import React, { useState } from "react";
import "./share.css";
import { PermMedia, Label, Room, EmojiEmotions } from "@material-ui/icons";

export default function Share() {
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [showPost, setShowPost] = useState(false);
  const [tagClicked, setTagClicked] = useState(false);

  const handleShare = () => {
    setShowPost(true);
  };

  const handleTagClick = () => {
    setTagClicked(true);
    setContent((prevContent) => (prevContent ? "#" + prevContent : "#"));
  };

  return (
    <div className="share">
      <div className="shareWrapper">
        <div className="shareTop">
          <img
            className="shareProfileImg"
            src="/assets/person/1.jpeg"
            alt=""
          />
          <div className="shareInputs">
            <div className="shareInputsWrapper">
              <input
                placeholder="Enter title"
                className="shareInputTitle"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
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
              <span className="shareOptionText">Photo or Video</span>
            </div>
            <div className="shareOption" onClick={handleTagClick}>
              <Label htmlColor="blue" className="shareIcon" />
              <span className="shareOptionText">Tag</span>
            </div>
            <div className="shareOption">
              <Room htmlColor="green" className="shareIcon" />
              <span className="shareOptionText">Location</span>
            </div>
          </div>
          <button className="shareButton" onClick={handleShare}>
            Share
          </button>
        </div>
      </div>

      {showPost && (
        <div className="post">
          <div className="postWrapper">
            <div className="postTop">
              <img
                className="postProfileImg"
                src="/assets/person/1.jpeg"
                alt=""
              />
              <span className="postTitle">{title}</span>
            </div>
            <div className="postContent">{content}</div>
          </div>
        </div>
      )}
    </div>
  );
}