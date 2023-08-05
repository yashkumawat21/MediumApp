import "./login.css";
import { useNavigate } from "react-router-dom";
export default function Login() {
  const navigate=useNavigate();
  const createAccount=()=>{
    navigate("/Signup");
  }
  const updatedfeed=()=>{
    navigate("/Updatedfeed");
  }
  return ( 
    <div className="login">
      <div className="loginWrapper">
        <div className="loginLeft">
          <h3 className="loginLogo">Lamasocial</h3>
          <span className="loginDesc">
            Connect with friends and the world around you on Lamasocial.
          </span>
        </div>
        <div className="loginRight">
          <div className="loginBox">
            <input placeholder="Email" className="loginInput" />
            <input placeholder="Password" className="loginInput" />
            <button className="loginButton" onClick={updatedfeed}>Log In</button>
            <span className="loginForgot">Forgot Password?</span>
            <button className="loginRegisterButton" onClick={createAccount}>
              Create a New Account
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
