<h1>Cobot Dashboard Repo</h1>
<p>This repo contains the files to both the dashboard itself, and a small test server to ensure the functionality of WebSockets while the true backend portion of the dashboard remains in developlemt.</p>

<h2>Overview of Repo Folders & Files</h2>
<h3>ChessboardJS Folder</h3>
<ul>
  <li>This folder simply contains the files necessary to implement the "chessboard.js" library</li>
  <li>See Chessboard documentation <a href="https://chessboardjs.com/index.html">here</a> when necessary.</li>
  <li>The main function from this library used in the dasboard is "Chessboard()"</li>
  <li>Specifically, the Chessboard() function is used to initiate a starter board and update that board as the game goes on. (See the index.html section below for further explanation)</li>
</ul>

<h3>Server Folder</h3>
<ul>
  <li>This folder contains the files necessary to run the small test server through VS Code.</li>
  <li>To begin the test server within VS Code, open a terminal within the folder and type "node index.js".</li>
  <li>Once started, the terminal window of the server will display a messgage whenever a client connects.</li>
  <img src="/sampleImgs/sampleTerminal.png">
  <li>To end the server, simply input "cntrl + z" in the terminal.</li>
  <li>If other dashboard functionality needs to be tested with the server, only the "index.js" should require alteration.</li>
</ul>

<h3>Style Folder</h3>
<ul>
  <li>Simply contains the CSS file that defines the styling for the main dashbaord page.</li>
  <li>The current styling remains somewhat simple as functionality was prioritized, further improvements are welcome.</li>
</ul>

<h3>Index.html File</h3>
<p>Note: This section will be split into each major area of the file (Head, Body, and JavaScript)</p>
<h4>Head</h4>
<ul>
  <li>In this section of the HTML file, the style sheets for both the chessboard.js library and the dashboard page are brought in.</li>
  <li>The chessboard.js library has a depency on JQuery, which is also taken care of here.</li>
  <li>Lastly, the JavaScript related to the Chessboard.js library is brought in to give the library its functionality.</li>
  <li>The JS found at the bottom of the HTML file can also be moved into its own file and brought here in the future if further organization is desired.</li>
</ul>
<h4>Body</h4>
<ul>
  <li>Here is where all the HTML of the file resides, splitting the page into its major sections.</li>
  <li>The "myBoard" div defines the area where the chessboard library is implemented to display the board to the users. If you would like the board to be initialized in a different way when the dashboard is first loaded, the parameters of the Chessboard() function can be edited according to the linked documenation above. </li>
  <li>The "gameInfo" div defines a place for the rest of the desired game info to be displayed to users. The value of each piece of game info is displayed through a "<span>" block to allow for the values to be updated easily as the game progresses.</li>
  <li>The "controlPanel" defines the area of the page that the user will interact with to manipulate various elements of the game. Each section of this panel contains buttons that run a related funtion when clicked. </li>
    <li>The last bit of HTML was created as a temporary testing area to ensure the chessboard library is running as intended. This part of the page contains some sample FEN strings to test the board updates correctly when it receives the real FEN strings from the backend.</li>
</ul>
<h4>JavaScript</h4>
<ul>
  <li>This section begins by creating an object "ws", a new WebSocket connection at the host computer, allowing communication with the test server. (This will have to be updated when connecting to the backend)</li>
  <li>Event listeners are then used with this "ws" object to detect a successful WebSocket connection and to detect incoming messages.</li>
  <li>The event listener block for "open" is entered when the WebSocket connection is successful, so the "connection status" part of the dashboard is updated with green "connected" text. </li>
  <img src="/sampleImgs/statusMsg.png">
  <li>A small test message is also sent to the server using the "ws.send" method, but this action is a bit redundant with the "connection status" part of the dashboard.</li>
  <li>The event listener block of "message" detects whenever a message, called "e" is received. Since messages are exchanged in string format, the received message is first converted to a JSON format with the JSON.parse method.</li>
  <li>If statements are then used to enter into various functions depending on what the message is related to. The exact names that the if statements check for may need to be changed based on the format of backend messages.</li>
  <li>The remaining JavaScript is a collection of fucntions that are used in the control panel portion of the dashboard. These functions contain checks for some of the inputs to prevent invalid values being sent to the backend.</li>
  <li>Once these functions gather the neccessary data, a JSON object is formed with the relevant info and converted into a string with the JSON.stringify method.</li>
  <li>A message is then sent to the server/backend with "ws.send([message])". On the backend's side, JSON.parse will have to be used to extract the sent data. Similarly to how it is done in the message receiving block of this front end.</li>
</ul>

