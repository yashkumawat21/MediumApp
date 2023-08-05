import Post from "../post/Post";
import Share from "../share/Share";
import "./nosharefeed.css";
import { Posts } from "../../dummyData";
import Topbar from "../topbar/Topbar";
import Sidebar from "../sidebar/Sidebar";
import Rightbar from "../rightbar/Rightbar";

export default function Nosharefeed() {
  return ( <>
   {/* <Topbar/> */}
   
    <div className="feed">
      <div className="feedWrapper">
        {Posts.map((p) => (
          <Post key={p.id} post={p} />
        ))}
      </div>
      </div>
    </>
  );
}
