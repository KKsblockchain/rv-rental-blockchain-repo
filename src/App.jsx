import { useState } from 'react'
import Navbar from './components/Navbar'
import Home from './components/home'
import Dashboard from './components/Dashboard'

import { BrowserRouter as Router, Route, Routes  } from "react-router-dom";

function App() {

  return (
    <>
    <Router>
    <Navbar />
    <Routes>
      <Route exact path="/" element={<Home />} />
      <Route exact path="/dashboard" element={<Dashboard />} />
    </Routes>
    </Router>
    </>
    )
}

export default App
