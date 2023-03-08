import React from "react";
import { Outlet, Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import { Container, Row, Col, Nav, Navbar } from "react-bootstrap";
import { signOut } from "../../store/session/actions";
import { useSelector, useDispatch } from "react-redux";
import "./home.css";

const Home = ({ children, ...rest }) => {
  const navigate = useNavigate();
  const dispatch = useDispatch();

  const onSignOut = (event) => {
    event.preventDefault();
    dispatch(signOut()).then(() => {
      navigate("/login");
    });
  };

  return (
    <Container className="vh-100 px-0" fluid>
      <Row className="flex-column h-100">
        <Col xs={12}>
          <Navbar bg="dark" variant="dark" expand="lg" fixed="top">
            <Nav className="me-auto">
              <Link to={"/dashboard"} className="nav-link">
                Dashboard
              </Link>

              <Link to={"/transactions"} className="nav-link">
                Transactions
              </Link>

              <Link to={"/merchants"} className="nav-link">
                Merchants
              </Link>
            </Nav>
            <Nav className="justify-content-end">
              <Link to={"/logout"} className="nav-link" onClick={onSignOut}>
                Logout
              </Link>
            </Nav>
          </Navbar>
        </Col>

        <Col xs={12} className="flex-grow-1">
          <main className="h-100">
            <Container>
              <Outlet />
            </Container>
          </main>
        </Col>

        <Col xs={12}>
          <Navbar
            fixed="bottom"
            bg="dark"
            variant="dark"
            className="justify-content-md-center"
          >
            <Navbar.Brand href="#home" className="text-center">
              Footer
            </Navbar.Brand>
          </Navbar>
        </Col>
      </Row>
    </Container>
  );
};

export default Home;
