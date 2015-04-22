
* client test process
  1) client emulation을 위한 Office용, Server용 SVI 생성 및 bridge 구성
     # ./01_create_bridges_client.sh 1
  2) server emulation을 위한 Internet용 bridge 구성
     # ./01_create_bridges_server.sh 1
  3) client emulation을 위한 office용, server용 client namespace 생성 및 networking 구성
     # ./02_create_clients.sh 1
  4) server emulation을 위한 internet용 namespace 생성 및 networking 구성
     # ./03_create_server.sh 1


  5) internet용 namespace에서 L3 스위치까지의 네트워킹 점검
     # ./21_server_ping_gw.sh 1
  6) server용 namespace에서 vUTM까지의 네트워킹 점검
     # ./31_client_ping_gw.sh 1
  7) _



