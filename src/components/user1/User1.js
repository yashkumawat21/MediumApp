import "./user1.css";
import Topbar from "../../components/topbar/Topbar";
import Sidebar from "../../components/sidebar/Sidebar";
import Nosharefeed from "../Nosharefeed/Nosharefeed";
import Newuserinfo from "../newuserinfo/Newuserinfo";
import { useState, useEffect } from "react";

import { useNavigate } from "react-router-dom";
export default function User1() {

  const navigate=useNavigate();
  const [isFollowing, setIsFollowing] = useState(false);

  // Load follow status from local storage on initial component mount
  useEffect(() => {
    const savedFollowStatus = localStorage.getItem("followStatus");
    if (savedFollowStatus) {
      setIsFollowing(JSON.parse(savedFollowStatus));
    }
  }, []);

  // Save follow status to local storage whenever it changes
  useEffect(() => {
    localStorage.setItem("followStatus", JSON.stringify(isFollowing));
  }, [isFollowing]);

  const handleFollowToggle = () => {
    setIsFollowing((prevIsFollowing) => !prevIsFollowing);
  };

  
  return (
    <>
      <Topbar />
      <div className="profile">
        <Sidebar />
        <div className="profileRight">
          <div className="profileRightTop">
            <div className="profileCover">
              <img
                className="profileCoverImg"
                src="assets/post/1.jpeg"
                alt=""
              />
              <img
                className="profileUserImg"
                src="assets/person/1.jpeg"
                alt=""
              />
            </div>
            <div className="profileInfo">
              <h4 className="profileInfoName">Elisa</h4>
              <span className="profileInfoDesc">You are best in so many ways</span>
              <button
                className={`followButton ${isFollowing ? "following" : ""}`}
                onClick={handleFollowToggle}
              >
                {isFollowing ? "Following" : "Follow"}
              </button>
            </div>
          </div>
          <div className="profileRightBottom">
            <Nosharefeed />
            <Newuserinfo profile />
          </div>
        </div>
      </div>
    </>
  );
}