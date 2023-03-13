import React from "react";
import Login from "../pages/Login";
import NoMatch from "../pages/404";
import Home from "../pages/Home";
import Dashboard from "../pages/Dashboard";
import Transactions from "../pages/Transactions/List";
import Merchants from "../pages/Merchants/List";
import Merchant from "../pages/Merchants/Form";
import PrivateRoute from "./PrivateRoute";

import { Routes, Route } from "react-router-dom";

const AppRoutes = () => (
  <Routes>
    <Route exact path={"/login"} element={<Login />} />

    <Route element={<Home />}>
      <Route
        path="/"
        element={
          <PrivateRoute>
            <Dashboard />
          </PrivateRoute>
        }
      />
      <Route
        path="/dashboard"
        element={
          <PrivateRoute>
            <Dashboard />
          </PrivateRoute>
        }
      />
      <Route
        path="/transactions"
        element={
          <PrivateRoute>
            <Transactions />
          </PrivateRoute>
        }
      />
      <Route
        path="/merchants"
        element={
          <PrivateRoute>
            <Merchants />
          </PrivateRoute>
        }
      />
      <Route
        path="/merchants/:id"
        element={
          <PrivateRoute>
            <Merchant />
          </PrivateRoute>
        }
      />
    </Route>

    <Route path="*" element={<NoMatch />} />
  </Routes>
);

export default AppRoutes;
