import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { Grid, Box, Typography } from '@mui/material';

export default function ProvidersListItem({ provider }) {
    const history = useHistory();
    const dispatch = useDispatch();

    const handleClick = (id) => {
        console.log('You clicked this Provider!', id);
        dispatch({ type: 'FETCH_PROVIDER_DETAILS', payload: id });
        dispatch({ type: 'FETCH_PROVIDER_SPECIALIZATIONS', payload: id });
        dispatch({ type: 'FETCH_PROVIDER_OCCUPATIONS', payload: id });
        dispatch({ type: 'FETCH_PROVIDER_INSURANCES', payload: id });
        dispatch({ type: 'FETCH_PROVIDER_SERVICES', payload: id });
        history.push(`/provider-details`);
    };

    return (
        // CONTAINER FOR POSITIONING ALL CARDS
        <>
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
                    onClick={() => handleClick(provider.id)}
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
                        noWrap: true,
                    
                        '&:hover': {
                            boxShadow: '0.1rem 0.1rem 1rem 0.1rem gray',
                            cursor: 'pointer',
                            transition: 'all 0.5s ease-in-out',
                        },
                    }}
                >
                    {/* LEFT COLUMN */}
                    <Grid Item
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
                                src={provider.picture}
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
                            // borderColor: 'red',
                            // borderStyle: 'dashed',

                        }}
                    >
                        {/* NAME */}
                        <Grid item 
                            >
                            <Typography
                                variant="h6"
                                sx={{
                                    padding: .1,
                                    margin: .1,
                                    // width: '30vw',
                                    minHeight: '2vh',
                                    maxWidth: '100%',
                                    color: 'var(--cornflower)',
                                }}
                            >
                                {provider.name}
                            </Typography>
                        </Grid>

                        {/* BIO */}
                        <Grid Item>
                            <Typography
                                variant="h6"
                                sx={{
                                    // width: '40vw',
                                    maxHeight: '100%',
                                    maxWidth: '100%',
                                    // height: '5vh',
                                    padding: .1,
                                    margin: .1,
                                    overflow: 'hidden', 
                                    textOverflow: 'ellipsis',
                                }}
                            >
                                {provider.bio}
                            </Typography>
                        </Grid>

                        {/* RIGHT COLUMN */}
                        <Grid
                            container
                            id="right-column"
                            sx={{
                                margin: 0.1,
                                padding: .01,
                                display: 'flex',
                                flexDirection: 'column',
                                justifyContent: 'left',
                            }}
                        >
                            {/* PHONE NUMBER */}
                            <Grid Item>
                                <Typography>{provider.phone}</Typography>
                            </Grid>
                            <Grid Item>
                                <Typography>{provider.email}</Typography>
                            </Grid>
                        </Grid>
                    </Grid>
                </Grid>
            </Box>
        </>
    );
}
