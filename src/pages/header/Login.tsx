import { Button, FormControl, FormControlLabel, FormHelperText, FormLabel, Grid, TextField, Typography } from "@mui/material";
import React from "react";
import BottomNavigation from "../../components/common/BottomNavigation";
import ValidatedForm from "../../components/common/ValidatedForm";
import { setNotificationMessage, setNotificationType, setNotificationStatus } from "../../redux/slices/notificationSlice";
import FormValidator from "../../services/FormValidator";
import { useDispatch } from "react-redux";

interface FormFields {
    username: string,
    password: string
}

const Login = () => {

    const [form, setForm] = React.useState<FormFields>({
        username: '',
        password: ''
    })

    const [errors, setErrors] = React.useState<FormFields>({
        username: '',
        password: ''
    })

    const dispatch = useDispatch()

    const validateForm = () => {

        let success = true

        let newErrorsState = {...errors}

        if(!FormValidator.checkIfIsRequired(form.username)){
            newErrorsState.username = FormValidator.requiredMessage
            success = false
        }

        if(!FormValidator.checkIfIsRequired(form.password)){
            newErrorsState.password = FormValidator.requiredMessage
            success = false
        }
        else if(!FormValidator.checkMinLength(form.password, 8)){
            newErrorsState.password = FormValidator.minLengthMessage
            success = false
        }
        else if(!FormValidator.checkContainsSmallLetter(form.password)){
            newErrorsState.password = FormValidator.smallLetterMessage
            success = false
        }
        else if(!FormValidator.checkContainsUpperLetter(form.password)){
            newErrorsState.password = FormValidator.upperLetterMessage
            success = false
        }
        else if(!FormValidator.checkContainsDigit(form.password)){
            newErrorsState.password = FormValidator.digitMessage
            success = false
        }

        setErrors(newErrorsState)

        return success
    }

    const handleSubmit = () => {

        if(!validateForm())
            return

        dispatch(setNotificationMessage('Zalogowano pomyślnie'))
        dispatch(setNotificationType('success'))
        dispatch(setNotificationStatus(true))
    }

    return (
        <React.Fragment>
            <Grid item xs={12} marginTop={16}>
                <Typography variant="h4" textAlign="center">
                    Logowanie
                </Typography>
            </Grid>
            <Grid item xs={3} container marginTop={10}>
                <ValidatedForm
                    fieldName="Nazwa użytkownika"
                    placeholder="Wpisz nazwę użytkownika..."
                    value={form.username}
                    error={errors.username}
                    onChange={(value) => setForm({...form, username: value})}
                    onErrorChange={(error) => setErrors({...errors, username: error})}
                />
                <ValidatedForm
                    fieldName="Hasło"
                    placeholder="Wpisz hasło..."
                    type="password"
                    value={form.password}
                    error={errors.password}
                    onChange={(value) => setForm({...form, password: value})}
                    onErrorChange={(error) => setErrors({...errors, password: error})}
                />
                <Grid item>
                    <Button
                        variant="text"
                        color="secondary"
                        sx={{color: '#1C3CAD'}}
                    >
                        Zapomniałem hasła
                    </Button>
                </Grid>
                <Grid item xs={6} container marginTop={10} justifyContent="center">
                    <Button
                        fullWidth
                        variant="contained"
                        color="secondary"
                        onClick={handleSubmit}
                    >
                        Zaloguj się
                    </Button>
                </Grid>
                <Grid item container justifyContent="center" marginTop={3}>
                    <Button
                        fullWidth
                        variant="text"
                        color="secondary"
                        sx={{color: '#1C3CAD'}}
                    >
                        Nie masz jeszcze konta? Zarejestruj się
                    </Button>
                </Grid>
            </Grid>
            <Grid item xs={12}>
                <BottomNavigation text={'Wróć do strony głównej'} path='../'/>
            </Grid>
        </React.Fragment>
    );
}

export default Login;