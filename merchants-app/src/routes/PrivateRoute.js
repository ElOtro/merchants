import React from "react";
import { useSelector } from "react-redux";
import Spinner from 'react-bootstrap/Spinner';
import { Navigate } from "react-router-dom";
import { history } from '../utils';

const PrivateRoute = ({ children }) => {
  const { isAuthenticated, isLoading } = useSelector((state) => state.auth);
  const spinnerStyle = {textAlign: 'center'};

  if (isLoading) {
    return (
      <div style={spinnerStyle}>
        <Spinner animation="border" />
      </div>
    );
  }

  if (!isAuthenticated) {
    // not logged in so redirect to login page with the return url
    return <Navigate to="/login" state={{ from: history.location }} />;
  }

  // authorized so return child components
  return children;
};

export default PrivateRoute;
