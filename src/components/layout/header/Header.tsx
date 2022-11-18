import { Toolbar, Box, Typography, Grid, AppBar, Button } from "@mui/material";
import { Link } from "react-router-dom";
import logo from "../../../assets/logo.png";
import basket from "../../../assets/basket.png";
import "./Header.css";
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

const Header = () => {
  const [isUserLogged, setIsUserLogged] = useState<boolean>(false);
  const navigate = useNavigate();

  return (
    <Grid container component="nav" alignItems="center">
      <Grid item xs={5} justifySelf="start">
        <Link to="/" className="nice-link">
          <img src={logo} width="100" />
        </Link>
      </Grid>
      <Grid
        item
        xs={2}
        justifySelf="center"
        container
        justifyContent="center"
        alignSelf="center"
      >
        <Typography component="h4" id="name" textAlign="center">
          Bookshop
        </Typography>
      </Grid>
      <Grid
        item
        xs={5}
        justifySelf="end"
        container
        alignItems="center"
        justifyContent="end"
        columnSpacing={3}
      >
        {isUserLogged ? (
          <React.Fragment>
            <Grid item>
              <Button variant="contained" color="secondary">
                Moje zamówienia
              </Button>
            </Grid>
            <Grid item>
              <Button
                variant="contained"
                color="secondary"
                onClick={() => setIsUserLogged(false)}
              >
                Wyloguj się
              </Button>
            </Grid>
          </React.Fragment>
        ) : (
          <React.Fragment>
            <Grid item>
              <Button
                variant="contained"
                color="secondary"
                onClick={() => navigate("/register")}
              >
                Zarejestruj się
              </Button>
            </Grid>
            <Grid item>
              <Button
                variant="contained"
                color="secondary"
                onClick={() => navigate("/login")}
              >
                Zaloguj się
              </Button>
            </Grid>
          </React.Fragment>
        )}
        <Grid item>
          <Link to="/basket" className="nice-link">
            <img src={basket} width="60" />
          </Link>
        </Grid>
      </Grid>
    </Grid>
  );
};

export default Header;
