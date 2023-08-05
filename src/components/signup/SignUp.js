import React from "react";
import { Formik, Form, Field, ErrorMessage } from "formik";
import * as Yup from "yup";
import "./signup.css";
import { useNavigate } from "react-router-dom";
const SignUp = () => {
  const initialValues = {
    name: "",
    password: "",
    verifyPassword: "",
    email: "",
  };

  const validationSchema = Yup.object().shape({
    name: Yup.string().required("Required"),
    password: Yup.string().required("Required"),
    verifyPassword: Yup.string()
      .oneOf([Yup.ref("password"), null], "Passwords must match")
      .required("Required"),
    email: Yup.string().email("Invalid email").required("Required"),
  });


  const navigate=useNavigate();
  const handleSubmit = (values, { setSubmitting }) => {
    // Your form submission logic here
    console.log("Form Values:", values); // Display all form details in the console
    setSubmitting(false);
    navigate("/Updatedfeed");

  };

  return (
    <div className="signup">
      <div className="signupWrapper">
        <div className="signupLeft">
          <h1 className="signupLogo">Sign Up</h1>
          <span className="signupDesc">Create your account</span>
        </div>
        <div className="signupRight">
          <Formik
            initialValues={initialValues}
            validationSchema={validationSchema}
            onSubmit={handleSubmit}
          >
            {({ isSubmitting }) => (
              <Form className="signupForm">
                <div>
                  <label htmlFor="name"></label>
                  <Field
                    type="text"
                    id="name"
                    name="name"
                    className="signupInput"
                    placeholder="Enter Name"
                  />
                  <ErrorMessage
                    name="name"
                    component="div"
                    className="signupError"
                  />
                </div>
                <div>
                  <label htmlFor="password"></label>
                  <Field
                    type="password"
                    id="password"
                    name="password"
                    className="signupInput"
                    placeholder="Enter Password"
                  />
                  <ErrorMessage
                    name="password"
                    component="div"
                    className="signupError"
                  />
                </div>
                <div>
                  <label htmlFor="verifyPassword"></label>
                  <Field
                    type="password"
                    id="verifyPassword"
                    name="verifyPassword"
                    className="signupInput"
                    placeholder="Verify password"
                  />
                  <ErrorMessage
                    name="verifyPassword"
                    component="div"
                    className="signupError"
                  />
                </div>
                <div>
                  <label htmlFor="email"></label>
                  <Field
                    type="email"
                    id="email"
                    name="email"
                    className="signupInput"
                    placeholder="Enter email ID"
                  />
                  <ErrorMessage
                    name="email"
                    component="div"
                    className="signupError"
                  />
                </div>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="signupButton"
                >
                  Sign Up
                </button>
              </Form>
            )}
          </Formik>
        </div>
      </div>
    </div>
  );
};

export default SignUp;