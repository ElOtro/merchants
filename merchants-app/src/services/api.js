import axios from "axios";
// import { message } from "antd";

export const baseURL = "http://localhost:4000/v1";

const api = axios.create({
  baseURL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

export const showErrors = (payload) => {
  const { error } = payload;
  if (error) {
    Object.entries(error).map((e) => {
      // return message.error(e.join(" "));
      console.log(e);
    });
  }
};

export const showSuccess = (payload) => {
  console.log(payload);
  // message.success(payload);
};

export default api;
