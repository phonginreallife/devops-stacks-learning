const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");
require('dotenv').config();


const corsOrigin = process.env.CORS_ORIGIN || '*'; // Default to '*' if not set

//middleware
app.use(cors({
    origin: `${corsOrigin}`,
  }));

// 🔧 Parse JSON bodies
app.use(express.json());

// 🔍 Logging middleware
app.use((req, res, next) => {
    const timestamp = new Date().toISOString();

    const xForwardedFor = req.headers['x-forwarded-for'];
    const rawIp = Array.isArray(xForwardedFor) ? xForwardedFor[0] :
                  (typeof xForwardedFor === 'string' ? xForwardedFor.split(',')[0].trim() : req.socket.remoteAddress);
    const ip = rawIp.startsWith("::ffff:") ? rawIp.slice(7) : rawIp;

    // Skip internal IPs
    if (!ip.startsWith('10.') && !ip.startsWith('192.168.') && !ip.startsWith('172.') && ip !== '127.0.0.1') {
        console.log(`[${timestamp}] ${req.method} ${req.originalUrl} - IP: ${ip}`);
        if (req.method !== 'GET') {
            console.log("Request Body:", req.body);
        }
    }

    next();
});
//create a todo
app.post("/todos", async(req, res) => {
    try {
        const { description } = req.body;
        const newTodo = await pool.query(
            "INSERT INTO todo (description) VALUES($1) RETURNING *",
            [description]
        );
        res.json(newTodo.rows[0]);
    } catch (err) {
        console.error("Error in POST /todos:", err.message);
        console.error(err.message);
    }
})

//get all todos
app.get("/todos", async(req, res) => {
    try {
        const allTodos = await pool.query("SELECT * FROM todo");
        res.json(allTodos.rows);
    } catch (err) {
        console.error("Error in GET /todos:", err.message);
        res.status(500).send("Server error");
    }
})

//get a todo
app.get("/todos/:id", async(req, res) => {
    try {
        const { id } = req.params;
        const todo = await pool.query(
            "SELECT * FROM todo WHERE todo_id = $1",
            [id]
        );
        res.json(todo.rows[0]);
    } catch (err) {
        console.error(err.message);
    }
})

//update a todo
app.put("/todos/:id", async(req, res) => {
    try {
        const { id } = req.params;
        const { description } = req.body;
        const updateTodo = await pool.query(
            "UPDATE todo SET description = $1 WHERE todo_id = $2",
            [description, id]
        );

        res.json("Todo was updated!");
    } catch (err) {
        console.error(err.message);
    }
})

//delete a todo
app.delete("/todos/:id", async(req, res) => {
    try {
        const { id } = req.params;
        const deleteTodo = await pool.query(
            "DELETE FROM todo WHERE todo_id = $1",
            [id]
        );
        res.json("Todo was deleted!");
    } catch (err) {
        console.error(err.message);
    }
})

app.listen(5000, () => {
    console.log("server has started on port 5000");
});