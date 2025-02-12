const WebSocket = require("ws");
const { exec } = require("child_process");

const wss = new WebSocket.Server({ port: 8080 });
console.log("WebSocket server is running on ws://localhost:8080");

function broadcast(data) {
    wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify(data));
        }
    });
}


function handleNewGame(msg, ws) {

    //handel erreo
    //if (msg.action === "runbash" && msg.token !== "VALID_TOKEN") {
    //    console.error("illegal");
    //    ws.send(JSON.stringify({ error: "invalid" }));
    //    return;
    //}

    if (msg.action === "runbash") {
        //exec("/home/cheesewoo/CoBot-Dashboard-main/test_lunch.sh", (error, stdout, stderr) => {
	exec("/home/cobot/745_ws/CoBot-Dashboard-main-20250205T202408Z-001/CoBot-Dashboard-main/lunch_cobot_2_5.sh", (error, stdout, stderr) => {

            if (error) {
                console.error("bash failed", error);
                ws.send(JSON.stringify({ error: "bash failed" }));
                return;
            }
            console.log("bash executed", stdout);
        });
    }

    //broadcast({
    //    name: "game_update",
    //    
    //});
}

wss.on("connection", ws => {
    console.log("New client has connected");

    ws.on("message", data => {
        try {
            const msg = JSON.parse(data);
            switch (msg.name) {
                case "new_game":
                    handleNewGame(msg, ws); 
                    break;
                case "set_enabled":
                case "add_time":
                    broadcast(msg); 
                    break;
                case "set_max_speed":
                    if (msg.speed < 0 || msg.speed > 1) {
                        console.error("illegal speed:", msg.speed);
                        ws.send(JSON.stringify({ error: "illegal speed" }));
                        return;
                    }
                    broadcast(msg);
                    break;
            }
        } catch (err) {
            console.error("invalid msg", err);
        }
    });

    ws.on("close", () => {
        console.log("Client has disconnected");
    });
});
