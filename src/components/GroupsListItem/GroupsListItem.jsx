import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { Grid, Box, Typography } from '@mui/material';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import CardActionArea from '@material-ui/core/CardActionArea';
import IconButton from '@mui/material/IconButton';
import DeleteOutlined from '@mui/icons-material/DeleteOutlined';
import Paper from '@material-ui/core/Paper';

export default function GroupsListItem({ group }) {
    const history = useHistory();
    const dispatch = useDispatch();
    //
    const handleClick = (id) => {
        console.log('You clicked this Group!', id);
        dispatch({ type: 'FETCH_GROUP_DETAILS', payload: id });
        history.push('/group-details');
    };

    return (

            <Box
                style={{
                    display: 'flex',
                    flexDirection: 'column',
                    justifyContent: 'center',
                    alignItems: 'center',
                    padding: 1,
                    width: '100vw',
                }}
            >
                {/* CARD BACKGROUND */}
                <Grid
                    Item
                    onClick={() => handleClick(group.id)}
                    sx={{
                        display: 'flex',
                        flexDirection: 'row',
                        justifyContent: 'left',
                        alignItems: 'flex-start',
                        border: '0.2rem solid var(--content)',
                        height: '22vh',
                        width: '70vw',
                        marginY: 2,
                        borderRadius: 5,

                        '&:hover': {
                            boxShadow: '0.1rem 0.1rem 1rem 0.1rem gray',
                            cursor: 'pointer',
                            transition: 'all 0.5s ease-in-out',
                        },
                    }}
                >
                    {/* LEFT COLUMN */}
                    <Grid
                        Item
                        sx={{
                            display: 'flex',
                            justifyContent: 'center',
                            alignItems: 'center',
                            borderRadius: 5,
                            margin: 'auto 1rem',
                        }}
                    >
                        <Grid item>
                            <img
                                src={group.picture}
                                style={{
                                    height: 'auto',
                                    width: 100,
                                }}
                            />
                        </Grid>
                    </Grid>
                    {/* CENTER COLUMN */}
                    <Grid
                        container
                        id="center-column"
                        sx={{
                            maxHeight: '100%',
                            display: 'flex',
                            flexDirection: 'column',
                            justifyContent: 'left',
                            overflow: 'hidden', 
                            textOverflow: 'ellipsis'
                        }}
                    >
                        {/* NAME */}
                        <Grid item>
                            <Typography
                                variant="h4"
                                sx={{
                                    // width: '30vw',
                                    // textOverflow: 'ellipsis',
                                    padding: .1,
                                    margin: .1,
                                    // width: '30vw',
                                    minHeight: '2vh',
                                    maxWidth: '100%',
                                    color: 'var(--cornflower)',
                                }}
                            >
                                {group.name}
                            </Typography>
                        </Grid>

                        {/* BIO */}
                        <Grid Item>
                            <Typography
                                variant="h6"
                                sx={{
                                    maxHeight: '100%',
                                    maxWidth: '100%',
                                    // width: '40vw',
                                    // height: '5vh',
                                }}
                            >
                                {/* {group.bio} */}
                            </Typography>
                        </Grid>

                        {/* RIGHT COLUMN */}
                        <Grid
                            container
                            id="right-column"
                            sx={{
                                margin: 0.3,
                                padding: .03,
                                display: 'flex',
                                flexDirection: 'column',
                                justifyContent: 'left',
                            }}
                        >
                            {/* PHONE NUMBER */}
                            <Grid Item>
                                <Typography>{group.phone}</Typography>
                            </Grid>
                            <Grid Item>
                                <Typography>{group.email}</Typography>
                            </Grid>
                        </Grid>
                    </Grid>
                </Grid>
            </Box>

    );
}
