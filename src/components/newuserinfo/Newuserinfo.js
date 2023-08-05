import React, { useState } from "react";
import "./newuserinfo.css";
import { Users } from "../../dummyData";
import Online from "../online/Online";


export default function Newuserinfo({ profile }) {
  const HomeRightbar = () => {
    return (
      <>
        {/* <img className="rightbarAd" src="assets/ad.png" alt="" /> */}
        <h4 className="rightbarTitle">Online Friends</h4>
        <ul className="rightbarFriendList">
          {Users.map((u) => (
            <Online key={u.id} user={u} />
          ))}
        </ul>
      </>
    );
  };

  const ProfileRightbar = () => {
    const [editMode, setEditMode] = useState(false);
    const [dateOfBirth, setDateOfBirth] = useState(new Date());
    const [place, setPlace] = useState("USA");
    const [articlesWritten, setArticlesWritten] = useState("2");
  
    const handleEditClick = () => {
      setEditMode(true);
    };
  
    const handleSaveClick = () => {
      // Perform save operation or update API call here
      setEditMode(false);
      // Additional logic to handle saving the data
    };
  
    const formatDate = (date) => {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");
      return `${year}-${month}-${day}`;
    };
  
    return (
      <>
        <h4 className="rightbarTitle">User information</h4>
        <div className="userInformationContainer">
          <div className="userInformation">
            <div className="rightbarInfoItem">
              <span className="rightbarInfoKey">Date of Birth:</span>
              {editMode ? (
                <input
                  type="date"
                  value={formatDate(dateOfBirth)}
                  onChange={(e) => setDateOfBirth(new Date(e.target.value))}
                  className="rightbarInfoValue"
                />
              ) : (
                <span className="rightbarInfoValue">{formatDate(dateOfBirth)}</span>
              )}
            </div>
            <div className="rightbarInfoItem">
              <span className="rightbarInfoKey">Place:</span>
              {editMode ? (
                <input
                  type="text"
                  value={place}
                  onChange={(e) => setPlace(e.target.value)}
                  className="rightbarInfoValue"
                />
              ) : (
                <span className="rightbarInfoValue">{place}</span>
              )}
            </div>
            <div className="rightbarInfoItem">
              <span className="rightbarInfoKey">Articles Written:</span>
              {editMode ? (
                <input
                  type="text"
                  value={articlesWritten}
                  onChange={(e) => setArticlesWritten(e.target.value)}
                  className="rightbarInfoValue"
                />
              ) : (
                <span className="rightbarInfoValue">{articlesWritten}</span>
              )}
            </div>
          </div>
          <div className="buttonContainer">

          </div>
        </div>
        <h4 className="rightbarTitle">User friends</h4>
        <div className="rightbarFollowings">
          <div className="rightbarFollowing">
            <img
              src="assets/person/7.jpeg"
              alt=""
              className="rightbarFollowingImg"
            />
            <span className="rightbarFollowingName">Saurabh</span>
          </div>
          <div className="rightbarFollowing">
            <img
              src="assets/person/2.jpeg"
              alt=""
              className="rightbarFollowingImg"
            />
            <span className="rightbarFollowingName">Johnson</span>
          </div>
          <div className="rightbarFollowing">
            <img
              src="assets/person/3.jpeg"
              alt=""
              className="rightbarFollowingImg"
            />
            <span className="rightbarFollowingName">Nicole</span>
          </div>
          <div className="rightbarFollowing">
            <img
              src="assets/person/4.jpeg"
              alt=""
              className="rightbarFollowingImg"
            />
            <span className="rightbarFollowingName">Michelle</span>
          </div>
          <div className="rightbarFollowing">
           
          </div>
        </div>
      </>
    );
  };
  return (
    <div className="rightbar">
      <div className="rightbarWrapper">
        {profile ? <ProfileRightbar /> : <HomeRightbar />}
      </div>
    </div>
  );
}
