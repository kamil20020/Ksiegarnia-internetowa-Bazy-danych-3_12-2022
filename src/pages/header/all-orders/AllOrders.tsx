import {
    Button,
    FormControl,
    FormControlLabel,
    FormHelperText,
    FormLabel,
    Grid,
    TextField,
    Typography,
  } from "@mui/material";
  import React from "react";
  import useEffect from "react";
  import { useDispatch } from "react-redux";
  import { useNavigate } from "react-router-dom";
import BottomNavigation from "../../../components/common/BottomNavigation";
import DatePickerFormRange from "../../../components/common/DatePickerFormRange";
import FormElement from "../../../components/common/FormElement";
import ValidatedForm from "../../../components/common/ValidatedForm";
import { setNotificationMessage, setNotificationType, setNotificationStatus } from "../../../redux/slices/notificationSlice";
import FormValidator from "../../../services/FormValidator";
import Box from '@mui/material/Box';
import { DataGrid, GridColDef, GridValueGetterParams } from '@mui/x-data-grid';
import Order from "../../../models/Order";
import OrderService from "../../../services/OrderService"
import { Pagination } from "../../../models/Pagination";
  
interface FormFields {
  name: string;
  surname: string;
  email: string;
  tel: string;
  creationDateFrom?: Date;
  creationDateTo?: Date;
  status: string;
  minPrice?: number;
  maxPrice?: number;
}

const columns: GridColDef[] = [
  { 
    field: 'id', 
    headerName: 'Nr',
    flex: 1,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'name',
    headerName: 'Imię',
    flex: 2,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'surname',
    headerName: 'Nazwisko',
    flex: 2,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'creationDate',
    headerName: 'Data utworzenia',
    flex: 2,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'num_of_products',
    headerName: 'Liczba produktów',
    flex: 2,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'price',
    headerName: 'Cena',
    type: 'number',
    flex: 1,
    align: 'center',
    headerAlign: 'center'
  },  {
    field: 'status',
    headerName: 'Status',
    type: 'number',
    flex: 3,
    align: 'center',
    headerAlign: 'center'
  },
  {
    field: 'email',
    headerName: 'Email',
    type: 'number',
    flex: 3,
    align: 'center',
    headerAlign: 'center'
  },

];
  //moment(order.creationDate).format("DD.MM.YYYY").toLocaleString()
const SearchOrders = () => {
  
  const [orders, setOrders] = React.useState<Order[]>([])

  const [form, setForm] = React.useState<FormFields>({
    name: "",
    surname: "",
    email: "",
    tel: "",
    status: "",
  });

  const [errors, setErrors] = React.useState<{email: string}>({
    email: ""
  });

  const [pagination, setPagination] = React.useState<Pagination>({
    page: 0,
    size: 5
  })

  const navigate = useNavigate();

  const dispatch = useDispatch();

  const validateForm = () => {
    let success = true;

    let newErrorsState = { ...errors };
    if (FormValidator.checkIfIsRequired(form.email)) {
      if (!FormValidator.checkEmail(form.name)) {
          newErrorsState.email = FormValidator.emailMessage;
          success = false;
      }
    } 

    setErrors(newErrorsState);

    return success;
  };

  const handleSubmit = () => {
    if (!validateForm()) return;

    OrderService.searchOrders(form, pagination)
    .then((response) => {
        //
    })
    .catch((error) => {
        dispatch(setNotificationMessage(error.message.data));
        dispatch(setNotificationType("error"));
        dispatch(setNotificationStatus(true));
    })
}

  return (
    <Grid item container justifyContent="center" alignSelf="start" marginTop={6}>
      <Grid item xs={12}>
        <Typography variant="h4" textAlign="center">
          Wyszukiwanie zamówień
        </Typography>
      </Grid>
      <Grid item xs={8} container marginTop={10} justifyContent="space-between">
        <Grid item xs={5} container rowSpacing={2}>
          <Grid item xs={12} marginBottom={2}>
            <FormElement
              fieldName="Imię"
              placeholder="Wpisz imię..."
              value={form.name}
              onChange={(value) => setForm({ ...form, name: value })}
            />
          </Grid>
          <FormElement
            fieldName="Nazwisko"
            placeholder="Wpisz nazwisko..."
            value={form.surname}
            onChange={(value) => setForm({ ...form, surname: value })}
          />
          <ValidatedForm
            fieldName="E-mail"
            placeholder="Wpisz e-mail..."
            value={form.email}
            error={errors.email}
            onChange={(value) => setForm({ ...form, email: value })}
            onErrorChange={(error) => setErrors({ ...errors, email: error })}
          />
          <FormElement
            fieldName="Numer telefonu"
            placeholder="Wpisz numer telefonu..."
            value={form.tel}
            onChange={(value) => setForm({ ...form, tel: value })}
          />
        </Grid>
        <Grid item xs={5} container rowSpacing={2}>
          <DatePickerFormRange
            fieldName="Data utworzenia"
            maxDate={new Date()}
            valueFrom={form.creationDateFrom}
            valueTo={form.creationDateTo}
            onChange={(newValue) => setForm({...form, creationDateTo: newValue != null ? newValue : undefined})}
          />
          <FormElement
            fieldName="Nazwisko"
            placeholder="Wpisz nazwisko..."
            value={form.surname}
            onChange={(value) => setForm({ ...form, surname: value })}
          />
          <FormElement
            fieldName="Numer telefonu"
            placeholder="Wpisz numer telefonu..."
            value={form.tel}
            onChange={(value) => setForm({ ...form, tel: value })}
          />
          <FormElement
            fieldName="Numer telefonu"
            placeholder="Wpisz numer telefonu..."
            value={form.tel}
            onChange={(value) => setForm({ ...form, tel: value })}
          />
        </Grid>
      </Grid>
      <Grid
        item
        xs={12}
        container
        marginTop={6}
        justifyContent="center"
      >
        <Grid item xs={1.5}>
          <Button
            fullWidth
            variant="contained"
            color="secondary"
            onClick={handleSubmit}
          >
            Szukaj
          </Button>
        </Grid>
      </Grid>
      <Grid item xs={10} marginTop={4}>
        <Box sx={{ height: 400, width: '100%' }} justifyContent="center">
          <DataGrid
            rows={orders}
            columns={columns}
            pageSize={5}
            rowsPerPageOptions={[5]}
            disableSelectionOnClick
            experimentalFeatures={{ newEditingApi: true }}
          />
        </Box>
      </Grid>
      <BottomNavigation text={"Wróć do strony głównej"} path="../" />
    </Grid>
  );
};

export default SearchOrders;