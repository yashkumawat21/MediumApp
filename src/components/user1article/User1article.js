import React, { useState, useEffect } from "react";
import Topbar from "../../components/topbar/Topbar";
import "./user1article.css";

export default function User1article() {
  const [donateAmount, setDonateAmount] = useState("");
  const [tagInput, setTagInput] = useState("");
  const [tags, setTags] = useState([]);
  const [counter, setCounter] = useState(0);

  const handleDonateChange = (e) => {
    setDonateAmount(e.target.value);
  };

  const handleTagChange = (e) => {
    setTagInput(e.target.value);
  };

  const handleDonateSubmit = (e) => {
    e.preventDefault();
    if (donateAmount.trim() !== "") {
      setTags([...tags, `${donateAmount}$ donated`]);
      setDonateAmount("");
    }
  };

  const handleTagSubmit = (e) => {
    e.preventDefault();
    if (tagInput.trim() !== "") {
      setTags([...tags, tagInput]);
      setTagInput("");
    }
  };

  // Update the counter every second
  useEffect(() => {
    const interval = setInterval(() => {
      setCounter((prevCounter) => prevCounter + 1);
    }, 1000);

    // Cleanup the interval on component unmount
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="history-container">
      <Topbar />
      <div className="historyprofile">
        <div className="postTitle">Love For All, Hatred For None</div>
        <br />

        <div className="postHeader">My first friend</div>
        <div className="authorName">Elisa</div>
        <br />
        <div className="postContent">
        May musical arrival beloved luckily adapted him. Shyness mention married son she his started now. Rose if as past near were. To graceful he elegance oh moderate attended entrance pleasure. Vulgar saw fat sudden edward way played either. Thoughts smallest at or peculiar relation breeding produced an. At depart spirit on stairs. She the either are wisdom praise things she before. Be mother itself vanity favour do me of. Begin sex was power joy after had walls miles.

Remain lively hardly needed at do by. Two you fat downs fanny three. True mr gone most at. Dare as name just when with it body. Travelling inquietude she increasing off impossible the. Cottage be noisier looking to we promise on. Disposal to kindness appetite diverted learning of on raptures. Betrayed any may returned now dashwood formerly. Balls way delay shy boy man views. No so instrument discretion unsatiable to in.

Am no an listening depending up believing. Enough around remove to barton agreed regret in or it. Advantage mr estimable be commanded provision. Year well shot deny shew come now had. Shall downs stand marry taken his for out. Do related mr account brandon an up. Wrong for never ready ham these witty him. Our compass see age uncivil matters weather forbade her minutes. Ready how but truth son new under.
        </div>
        <div className="postCounter">Time Spent: {counter} seconds</div>
        <form onSubmit={handleDonateSubmit}>
          <input
            type="text"
            placeholder="Enter amount"
            value={donateAmount}
            onChange={handleDonateChange}
          />
          <button type="submit">Donate</button>
        </form>
        <form onSubmit={handleTagSubmit}>
          <input
            type="text"
            placeholder="Enter tag"
            value={tagInput}
            onChange={handleTagChange}
          />
          <button type="submit">Add Tag</button>
        </form>
        <div className="tagsContainer">
          {tags.map((tag, index) => (
            <div key={index} className="tagBox">
              {tag}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}