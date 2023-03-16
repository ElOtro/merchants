import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Form, Button } from "react-bootstrap";
import { useDispatch } from "react-redux";
import { postMerchant } from "../../../store/merchants/merchantsApi";

const FormCreate = ({ merchantID, merchant = [] }) => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const [validated, setValidated] = useState(false);
  const [status, setStatus] = useState(merchant.status);
  const [email, setEmail] = useState(merchant.email);
  const [name, setName] = useState(merchant.name);
  const [description, setDescription] = useState(merchant.description);
  const [password, setPassword] = useState("");
  const [password_confirmation, setPasswordConfirmation] = useState("");

  const onSubmit = (event) => {
    const form = event.currentTarget;
    if (form.checkValidity() === false) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.preventDefault();
      dispatch(
        postMerchant({
          payload: {
            merchant: {
              status: status,
              email: email,
              name: name,
              description: description,
              password: password,
              password_confirmation: password_confirmation,
            },
          },
        })
      ).then(() => {
        navigate("/merchants");
      });
    }
  };

  return (
    <Form validated={validated} onSubmit={onSubmit}>
      <Form.Group className="mb-3">
        <Form.Label>Status</Form.Label>
        <Form.Check
          type="switch"
          checked={status}
          onChange={(e) => setStatus(e.target.checked)}
        />
      </Form.Group>
      <Form.Group className="mb-3">
        <Form.Label>Email address</Form.Label>
        <Form.Control
          required
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </Form.Group>
      <Form.Group className="mb-3">
        <Form.Label>Name</Form.Label>
        <Form.Control
          required
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
      </Form.Group>
      <Form.Group className="mb-3">
        <Form.Label>Description</Form.Label>
        <Form.Control
          required
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
      </Form.Group>
      <Form.Group className="mb-3">
        <Form.Label>Password</Form.Label>
        <Form.Control
          required
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </Form.Group>
      <Form.Group className="mb-3">
        <Form.Label>Password Confirmation</Form.Label>
        <Form.Control
          required
          value={password_confirmation}
          onChange={(e) => setPasswordConfirmation(e.target.value)}
        />
      </Form.Group>
      <Button variant="primary" type="submit">
        Submit
      </Button>
    </Form>
  );
};

export default FormCreate;
