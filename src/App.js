import Home from "./pages/home/Home";
import Login from "./pages/login/Login";
import Profile from "./pages/profile/Profile";
import Register from "./pages/register/Register";
import Signup from "./components/signup/SignUp";
import User1article from "./components/user1article/User1article";
import Updatedfeed from "./components/updatedfeed/Updatedfeed";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import * as React from 'react';
import User1 from "./components/user1/User1";

function App() {
  return(
  <div className="App">
  <BrowserRouter>
  <Routes>
        <Route path="/" element={<Home />} />
        <Route path="login" element={<Login />} />
         <Route path="profile" element={<Profile />} />
        <Route path="Register" element={<Register />} />
        <Route path="Signup" element={<Signup/>}/>
        <Route path="Updatedfeed" element={<Updatedfeed/>}/>
        <Route path="User1" element={<User1/>}/>
        <Route path="User1article" element={<User1article/>}/>
   </Routes>
  </BrowserRouter>
  </div>
  )
}

export default App;
