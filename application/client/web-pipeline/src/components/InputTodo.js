import React, { Fragment, useState } from "react";

const InputTodo = () => {
    const [description, setDescription] = useState("");

    const onSubmitForm = async e => {
        e.preventDefault(); //avoid refresh
        try {
            const body = { description };
            const response = await fetch(`${process.env.REACT_APP_API_URL}/todos`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            window.location = "/";
        } catch (err) {
            console.error(err.message);
        }
    };

    return (
        <Fragment>
            <h1 className="text-center mt-5">Pern Todo List</h1>
            <form className="d-flex mt-5" onSubmit={onSubmitForm}>
                <input
                    type="text"
                    className="form-control"
                    value={description}
                    onChange={e => setDescription(e.target.value)}
                />
                <button className="btn btn-success">Add</button>
            </form>
        </Fragment>
    );
};

export default InputTodo;
