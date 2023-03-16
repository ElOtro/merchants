import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import { login } from "../../store/session/actions";
import { useSelector, useDispatch } from "react-redux";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import "./login.css";

const Login = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const [validated, setValidated] = useState(false);

  const [email, setEmail] = useState("admin@example.com");
  const [password, setPassword] = useState("12345678");
  const [credentialError, setCredentialError] = useState(false);

  const onSubmit = (event) => {
    const form = event.currentTarget;
    if (form.checkValidity() === false) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.preventDefault();
      setValidated(true);
      dispatch(login({ email: email, password: password })).then(() => {
        navigate("/");
      });
    }
  };

  return (
    <main className="form-signin w-100 m-auto text-center">
      <Form noValidate validated={validated} onSubmit={onSubmit}>
        <h1 className="h3 mb-3 fw-normal">Please sign in</h1>
        <div className="form-floating">
          <Form.Control
            required
            id="floatingInput"
            type="email"
            placeholder="Enter email"
            defaultValue={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <Form.Label htmlFor="floatingInput">Email address</Form.Label>
        </div>
        <div className="form-floating">
          <Form.Control
            required
            id="floatingPassword"
            type="password"
            placeholder="Password"
            defaultValue={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <Form.Label htmlFor="floatingPassword">Password</Form.Label>

          <Button className="w-100" variant="primary" type="submit">
            Submit
          </Button>
        </div>
      </Form>
    </main>
  );
};

export default Login;
