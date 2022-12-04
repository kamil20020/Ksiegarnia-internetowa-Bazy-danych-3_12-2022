import React from "react";
import { useSelector } from "react-redux";
import { Navigate } from "react-router-dom";
import Forbidden from "../../pages/errors/Forbidden";
import { RootState } from "../../redux/store";

type ProtectedRouteProps = {
    children: React.ReactNode,
    isEmployee?: boolean
};

const ProtectedRoute = (props: ProtectedRouteProps) => {

    const userDetails = useSelector((state: RootState) => state);

    if(props.isEmployee == undefined){
        return <React.Fragment>{props.children}</React.Fragment>
    }

    if(!props.isEmployee){
        return userDetails.user.clientId ? <React.Fragment>{props.children}</React.Fragment> : <Forbidden/>
    }

    return userDetails.user.isLogged && !userDetails.user.clientId ? <React.Fragment>{props.children}</React.Fragment> : <Forbidden/>
}

export default ProtectedRoute;