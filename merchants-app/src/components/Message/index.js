import React, { useState } from "react";
import Alert from "react-bootstrap/Alert";

const Message = ({messages = [], variant = "success"}) => {
  const [showAlert, setShowAlert] = useState(true);
  return (
    showAlert && (
      <Alert variant={variant} onClose={() => setShowAlert(false)} dismissible>
        {messages.map((message) => (
          <p>{message}</p>
        ))}
      </Alert>
    )
  );
};

export default Message;
