import React from "react";
import "./paytoview.css";
import { Box, Typography } from "@mui/material";

const paytoview = () => {
  return (
    <div className="popupContainer">
      <Box className="box" sx={{ bgcolor: "#f1c40f", color: "#ffffff" }}>
        <Typography variant="h5">Be a Regular Guy</Typography>
        <Typography variant="body1">1 post a day for free</Typography>
      </Box>
      <Box className="box" sx={{ bgcolor: "#2ecc71", color: "#ffffff" }}>
        <Typography variant="h5">Start the Grind</Typography>
        <Typography variant="body1">3 posts a day for $3</Typography>
      </Box>
      <Box className="box" sx={{ bgcolor: "#3498db", color: "#ffffff" }}>
        <Typography variant="h5">Keep the Grind</Typography>
        <Typography variant="body1">5 posts a day for $5</Typography>
      </Box>
      <Box className="box" sx={{ bgcolor: "#9b59b6", color: "#ffffff" }}>
        <Typography variant="h5">You Are a Legend</Typography>
        <Typography variant="body1">10 posts a day for $10</Typography>
      </Box>
    </div>
  );
};

export default paytoview;