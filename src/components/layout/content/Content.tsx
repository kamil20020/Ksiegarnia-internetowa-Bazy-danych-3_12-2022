import { Grid } from "@mui/material";

type ContentProps = {
    children: React.ReactNode;
};

const Content = ({ children }: ContentProps) => {
    return (
        <main>
            <Grid container justifyContent="center" alignItems="stretch">
                {children}
            </Grid>
        </main>
    )
}

export default Content;