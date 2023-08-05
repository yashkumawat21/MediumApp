import "./sidebar.css";
import React, { useEffect, useState } from "react";
import {
  RssFeed,
  Chat,
  PlayCircleFilledOutlined,
  Group,
  Bookmark,
  HelpOutline,
  WorkOutline,
  Event,
  School,
} from "@material-ui/icons";
import { Users } from "../../dummyData";
import CloseFriend from "../closeFriend/CloseFriend";
import { useNavigate } from "react-router-dom";
export default function Sidebar() {
  const navigate=useNavigate();
  const sendfeed=()=>{
    navigate("/Updatedfeed");
  }
  return (
    <div className="sidebar">
      <div className="sidebarWrapper">
        <ul className="sidebarList">
          <li className="sidebarListItem">
              <RssFeed className="sidebarIcon" />
              <span className="sidebarListItemText" onClick={sendfeed}>Feed</span>
          </li>
          <li className="sidebarListItem">
            <a href="/saved" className="sidebarLink">
              <Bookmark className="sidebarIcon" />
              <span className="sidebarListItemText">Saved</span>
            </a>
          </li>
          <li className="sidebarListItem">
            <a href="/drafts" className="sidebarLink">
              <WorkOutline className="sidebarIcon" />
              <span className="sidebarListItemText">Drafts</span>
            </a>
          </li>
          <li className="sidebarListItem">
            <a href="/history" className="sidebarLink">
              <Event className="sidebarIcon" />
              <span className="sidebarListItemText">History</span>
            </a>
          </li>
        </ul>
        <hr className="sidebarHr" />
        <ul className="sidebarFriendList">
          {Users.map((u) => (
            <CloseFriend key={u.id} user={u} />
          ))}
        </ul>
      </div>
    </div>
  );
}