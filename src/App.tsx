import { AppBar, createTheme, ThemeProvider } from "@mui/material";
import React from "react";
import { plPL } from "@mui/material/locale";
import { Route, BrowserRouter, Routes, Outlet } from "react-router-dom";
import Header from "./components/layout/header/Header";
import Content from "./components/layout/content/Content";
import Shop from "./pages/shop/Shop";
import Login from "./pages/header/Login";
import Register from "./pages/header/Register";
import Notification from "./components/common/Notification";
import NotFound from "./pages/errors/NotFound";
import './index.css';
import BookDetails from "./pages/book-details/BookDetails";
import Basket from "./pages/basket/Basket";
import OrderView from "./pages/order/OrderView";
import MyOrders from "./pages/header/my-orders/MyOrders";

const theme = createTheme(
  {
    typography: {
      fontFamily: "Source Sans Pro, sans-serif",
      fontSize: 13,
      fontWeightLight: 300,
      fontWeightRegular: 400,
      fontWeightMedium: 500,
      button: {
        textTransform: "none",
      },
    },
    palette: {
      primary: {
        main: "#ca2f2f",
        contrastText: "#000",
      },
      secondary: {
        main: "#D9D9D9",
        contrastText: "#000",
      },
      info: {
        main: "#008080",
        contrastText: "#fff",
      },
      background: {
        paper: '#E8EEF6'
      }
    },
  },
  plPL
);

function App() {
  return (
    <React.StrictMode>
      <BrowserRouter>
        <ThemeProvider theme={theme}>
          <Header />
          <Content>
            <Routes>
              <Route path="/" element={<Shop />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="/book-details/:bookId" element={<BookDetails />} />
              <Route path="/basket" element={<Basket/>} />
              <Route path="/order" element={<OrderView />} />
              <Route path="/my-orders" element={<MyOrders />} />
              <Route path="*" element={<NotFound /> } />
            </Routes>
          </Content>
        </ThemeProvider>
      </BrowserRouter>
      <Notification />
    </React.StrictMode>
  );
}

export default App;
