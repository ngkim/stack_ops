* 주의: 이 폴더 안의 스크립트들은 first_run이 완료된 후에 진행해야 함

목적: 하나의 C-node에 VM 100개 만들기 테스트

* 체크사항
  
  1) nova와 neutron의 quota
     - nova의 instance, core, ram, floatingip, security_group
     - 현재의 nova-quota 설정값들

        # nova quota-show
        +-----------------------------+-------+
        | Quota                       | Limit |
        +-----------------------------+-------+
        | instances                   | 10    |
        | cores                       | 20    |
        | ram                         | 51200 |
        | floating_ips                | 10    |
        | fixed_ips                   | -1    |
        | metadata_items              | 128   |
        | injected_files              | 5     |
        | injected_file_content_bytes | 10240 |
        | injected_file_path_bytes    | 255   |
        | key_pairs                   | 100   |
        | security_groups             | 10    |
        | security_group_rules        | 20    |
        +-----------------------------+-------+
        
     - neutron의 network, port, router, security_group 사용 예상량
     - 현재의 neutron-quota 설정값들

        # neutron quota-show
        +---------------------+-------+
        | Field               | Value |
        +---------------------+-------+
        | floatingip          | 50    |
        | network             | 10    |
        | port                | 50    |
        | router              | 10    |
        | security_group      | 10    |
        | security_group_rule | 100   |
        | subnet              | 10    |
        +---------------------+-------+

* VM 생성 Process
  1) network 생성
     # ./05_create_provider_net.sh 1
  2) VM 생성
     # ./06_nova_boot_multinic.sh 1


