#include <windows.h>
#include <stdio.h>
#include <stdint.h>

static HANDLE hCom[2] = {INVALID_HANDLE_VALUE, INVALID_HANDLE_VALUE};

#ifdef __cplusplus
extern "C" {
#endif

// Khởi tạo cổng COM (dev_id: 0 = C# App, 1 = Java/Hercules Sensor)
int init_com_port(int dev_id, const char* port_name, int baudrate) {
    if (dev_id < 0 || dev_id > 1) return 0;
    
    char full_name[20];
    sprintf_s(full_name, sizeof(full_name), "\\\\.\\%s", port_name);

    hCom[dev_id] = CreateFileA(full_name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
    if (hCom[dev_id] == INVALID_HANDLE_VALUE) {
        printf("[C-Bridge LỖI] Không mở được %s (Device %d)\n", port_name, dev_id);
        return 0;
    }

    DCB dcb = {0};
    dcb.DCBlength = sizeof(dcb);
    GetCommState(hCom[dev_id], &dcb);
    dcb.BaudRate = baudrate;
    dcb.ByteSize = 8;
    dcb.StopBits = ONESTOPBIT;
    dcb.Parity   = NOPARITY;
    SetCommState(hCom[dev_id], &dcb);

    COMMTIMEOUTS timeouts = {0};
    timeouts.ReadIntervalTimeout = 1; // Non-blocking read
    SetCommTimeouts(hCom[dev_id], &timeouts);

    printf("[C-Bridge] Kết nối thành công %s (Device %d)\n", port_name, dev_id);
    return 1;
}

// Đọc 1 byte từ cổng COM chỉ định
int read_com_byte(int dev_id, uint8_t *data) {
    if (dev_id < 0 || dev_id > 1 || hCom[dev_id] == INVALID_HANDLE_VALUE) return 0;
    DWORD bytesRead = 0;
    if (ReadFile(hCom[dev_id], data, 1, &bytesRead, NULL) && bytesRead > 0) {
        return 1;
    }
    return 0;
}

// Gửi 1 byte ra cổng COM chỉ định
void write_com_byte(int dev_id, uint8_t data) {
    if (dev_id < 0 || dev_id > 1 || hCom[dev_id] == INVALID_HANDLE_VALUE) return;
    DWORD bytesWritten = 0;
    WriteFile(hCom[dev_id], &data, 1, &bytesWritten, NULL);
}

void close_all_com_ports() {
    for(int i = 0; i < 2; i++) {
        if (hCom[i] != INVALID_HANDLE_VALUE) {
            CloseHandle(hCom[i]);
            hCom[i] = INVALID_HANDLE_VALUE;
        }
    }
}

#ifdef __cplusplus
}
#endif