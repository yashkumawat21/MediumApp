import { createSlice } from "@reduxjs/toolkit";
import { uiActions } from "./ui-slice";
import { json } from "react-router-dom";

const posts=JSON.parse(localStorage.getItem("posts"));

const postsSlice = createSlice({
  name: "cart",
  initialState: {
   postsList:posts
  },
  reducers: {
    addPost(state,action){
        const newPost={}
        newPost.title=action.payload.title;
        newPost.desc=action.payload.desc;
        newPost.like=0;
        newPost.comment="";
    }
  },
});

export const postsActions = postsSlice.actions;

export default postsSlice;