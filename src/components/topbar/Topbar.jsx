import Signup from "../signup/SignUp";
import "./topbar.css";
import { Search, Person, Chat, Notifications } from "@material-ui/icons";


export default function Topbar() {
  return (
    <div className="topbarContainer">
      <div className="topbarLeft">
        <span className="logo">Medium.com</span>
        
       
        
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
        <div className="topbarLinks">
          <span className="topbarLink">Homepage</span>
          <span className="topbarLink">Timeline</span>
          <span className="topbarLink">Go PRO!</span>
        </div>
        <span className="signupLogin">
          <a href="/signup" className="signup_signup">Sign up</a>
          <p className="lining">|</p>
          <a href="/login">Login</a>
        </span>
        <img src="/assets/person/1.jpeg" alt="" className="topbarImg"/>
      </div>
    </div>
  );
}