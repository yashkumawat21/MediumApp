import { useState } from "react";
import "./topbar.css";
import { Search, Person, Chat, Notifications } from "@material-ui/icons";
import { useNavigate } from "react-router-dom";

export default function Topbar() {
  const [sortBy, setSortBy] = useState("");
  const [filterBy, setFilterBy] = useState("");
  const [filterValue, setFilterValue] = useState("");
  const navigate=useNavigate();
  const handleSortByChange = (event) => {
    setSortBy(event.target.value);
  };
 const showProfile=()=>{
  navigate("/Profile");
 }
 const sendHome=()=>{
  navigate("/");
 }
  const handleFilterByChange = (event) => {
    setFilterBy(event.target.value);
  };

  const handleFilterValueChange = (event) => {
    setFilterValue(event.target.value);
  };

  let filterInput = null;
  if (filterBy === "date") {
    filterInput = (
      <input
        type="date"
        className="filterInput"
        value={filterValue}
        onChange={handleFilterValueChange}
      />
    );
  }

  return (
    <div className="topbarContainer">
      <div className="topbarLeft">
        <span className="logo">Medium</span>
        <div className="topbarSortBy">
          <label htmlFor="sortby" className="sortby">Sort by:</label>
          <select
            id="sortby"
            name="sortby"
            value={sortBy}
            onChange={handleSortByChange}
          >
            <option value="">None</option>
            <option value="likes">Number of Likes</option>
            <option value="comments">Number of Comments</option>
          </select>
        </div>
        <div className="topbarFilterBy">
          <label htmlFor="filterby">Filter by:</label>
          <select
            id="filterby"
            name="filterby"
            value={filterBy}
            onChange={handleFilterByChange}
          >
            <option value="">None</option>
            <option value="author">Author</option>
            <option value="date">Date</option>
          </select>
        </div>
      </div>
      <div className="topbarCenter">
        <div className="searchbar">
          <Search className="searchIcon" />
          <input
            placeholder="Search for friend, post or video"
            className="searchInput"
          />
        </div>
      </div>
      <div className="topbarRight">
        {filterInput}
        <div className="topbarLinks">
          <span className="topbarLink" onClick={sendHome}>Homepage</span>
          <span className="topbarLink">Timeline</span>
          <span className="topbarLink">Go PRO!</span>
        </div>
        <span className="signupLogin">
          <a href="/signup" className="signup_signup">Sign up</a>
          <p className="lining">|</p>
          <a href="/login">Login</a>
        </span>
        <img src="/assets/person/1.jpeg" alt="" className="topbarImg" onClick={showProfile}/>
      </div>
    </div>
  );
}