import axios from "axios";
import Alert from "react-bootstrap/Alert";

export const baseURL = "http://localhost:4000/v1";

const api = axios.create({
  baseURL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

export const showErrors = (payload) => {
  const { errors } = payload;
  if (errors) {
    errors.map((error, i) => {
      return (
        <Alert key={i} variant="danger">
          {error}
        </Alert>
      );
    });
  }
};

export default api;
