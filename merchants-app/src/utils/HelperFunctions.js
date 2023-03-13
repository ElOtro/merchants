import { Badge } from "react-bootstrap";

export const getToken = () => {
  return localStorage.getItem("token");
};

export const removeToken = () => {
  localStorage.removeItem("token");
};

export const setToken = (val) => {
  localStorage.setItem("token", val);
};

export const statuses = (status) => {
  switch (status) {
    case "error":
      return <Badge bg="danger">{status}</Badge>;
    case "approved":
      return <Badge bg="success">{status}</Badge>;
    case "pending":
      return <Badge bg="warning">{status}</Badge>;
    default:
      return <Badge bg="secondary">{status}</Badge>;
  }
};
