import React, { useEffect, useState } from 'react';
import '../ProviderProfile/ProviderProfile.css';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom'
import { Link } from 'react-router-dom';

import LogOutButton from '../LogOutButton/LogOutButton';
import { Box, Card, Button, Grid, Paper, TextField, Typography, Tooltip, Input } from '@mui/material';





export default function GroupProfile() {

    const user = useSelector(store => store.user); // pulls user info for conditional rendering, and GETTING provider info
    const details = useSelector((store) => store.details); // Pulls a single Provider info from the "Details" store
    const [edit, setEdit] = useState(false); // edit buttons local state. Starts as false.
    const history = useHistory()
    const dispatch = useDispatch();

    console.log("user:", user); // test user info
    console.log("edit useState:", edit); // tests EDIT local state, starts as FALSE


  // Adding comment to commit

    const toggleEdit = () => { // Toggle the EDIT useState between TRUE & FALSE. 
        setEdit(current => !current);
    };

    useEffect(() => {
        dispatch({ type: 'FETCH_GROUP_PROFILE', payload: user.id })


    }, []);


    return (
      <Grid container className="row"
      style={{
        // width: 'fit-content',

      display: 'flex',
      flexDirection: 'row',
        borderStyle: 'solid',
        borderColor: 'black',
      }}    
      >
        <Grid Item className="column"
      style={{
        margin: .1,
        padding: .1,
      }}     
                    >
          <h1>Group Profile</h1>
          <Grid Item>
            <img
              style={{
                width: 300,
                height: 300,
                margin: '1rem',
                borderRadius: 20,
              }}
              src={details.picture}
              />
            </Grid>

          <Grid Item>
            {' '}
            {/* this div controller the "EDIT" buttons conditional rendering*/}
            <Button item variant="contained">
              Email
            </Button>
            {edit ? (
              <Button item variant="outlined" onClick={toggleEdit}>
                Submit Your Changes
              </Button>
            ) : (
              <Button item variant="contained" onClick={toggleEdit}>
                Edit Profile Info
              </Button>
            )}
          </Grid>
        </Grid>


          {/* this div controls the "Input fields & Info" conditional rendering*/}
          {edit ? (
            <div>
              {' '}
              {/* "?" - If TRUE, show input editable fields  */}
              <div className="column">
                <h3>You Are Editing Your Profile Info</h3>
                <TextField label={'Edit Name'}></TextField>
                <TextField label={'Edit Bio'}></TextField>
                <TextField label={'Edit Website'}></TextField>
                <TextField label={'Edit Phone Number'}></TextField>
              </div>
              <div className="column">
                <TextField label={'Edit Street'}></TextField>
                <TextField label={'Edit City'}></TextField>
                <TextField label={'Edit State'}></TextField>
                <TextField label={'Edit Zipcode'}></TextField>
              </div>
            </div>
          ) : (
            <Grid Item className="row"  xl={9} lg={8}  md={12} sx={12}               
            style={{
              // width: 'fit-content',
              margin: .1,
              padding: .1,
            }}   >
              {' '}
              {/* ":" - If FALSE, show Non-editable Text Below */}
              {/* COLUMN 1 */}
              <Grid Item className="column" 
                  style={{
                    width: 'fit-content',
                    height: 'fit-content',
                  }} 
              >
                <Typography margin=".25rem" className="info">{details.name}</Typography>
                <Typography margin=".25rem" className="info">{details.bio}</Typography>
                <Grid Item margin=".25rem" className="info">
                  <Typography>{details.street}</Typography>
                  <Typography>{details.city}</Typography>
                  <Typography>{details.state}</Typography>
                  <Typography>{details.zipcode}</Typography>
                </Grid>

                <Grid Item  margin=".25rem" className="column info"  >
                  <Typography >{details.website}</Typography>
                  <Typography>{details.email}</Typography>
                  <Typography>{details.phone}</Typography>
                </Grid>
              </Grid>
              {/* COLUMN 2 */}
            </Grid>
          )}

      </Grid>
    );
}
