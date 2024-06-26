Chain Validation Tutorial (C)
===

This repository holds the source code for the Net Privacy Pro Chain Validation tutorial in C. Here, you can find a server and a client application, both using OpenSSL to establish a connection, the client verifies the server's certificate. They then securely transmit data back and forth before closing the connection cleanly again. You can find the respective tutorial [here](https://netprivacypro.com/how-to-implement-chain-validation-in-c-on-linux/).

Dependencies
---

For this project to work, you need to install the necessary dependencies. If you use Debian or Ubuntu, install ```libssl-dev``` and ```openssl```:
```bash
sudo apt-get install libssl-dev openssl
```

For other distributions, please refer to your respective package manager documentation.

Generating SSL Certificates
---

This repository contains a convenience script for generating the required SSL certificates. Run this command to generate and verify them automatically:
```bash
./gen_certs.sh
```

Building the Applications
---

To build the project, simply invoke its ```Makefile``` on a command shell:
```bash
make
```

This should build the required ```server``` and ```client``` binaries.

Running the Server and Client
---

The server listens for socket connections on port 4910. Just run the server on one console, and run the client on a separate console on the same host. The client will automatically connect to the server.

The client will send a "Ping" message to the server, which will respond with "Pong". The client will terminate right after receiving the response, while the server will keep running until manually quit. It can answer multiple subsequent requests from clients.

License
---

This project is distributed under a BSD-3 license. Please credit [Net Privacy Pro](https://netprivacypro.com) if you use it or refer to it. Please refer to the LICENSE file in this repository for more information.

Contact
---

If you have questions or would like to get in touch for other reasons, please reach out to [info@netprivacypro.com](info@netprivacypro.com).
