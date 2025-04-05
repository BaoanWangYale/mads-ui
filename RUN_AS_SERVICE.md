# Running MADS UI as a Service

This document provides instructions on how to run the MADS UI application as a background service on different operating systems.

## Linux/macOS (Bash)

### Using the Shell Script

1. Make the script executable:
   ```bash
   chmod +x start-app.sh
   ```

2. Start the application:
   ```bash
   ./start-app.sh start
   ```

3. Check the status:
   ```bash
   ./start-app.sh status
   ```

4. View logs:
   ```bash
   ./start-app.sh logs
   ```

5. Stop the application:
   ```bash
   ./start-app.sh stop
   ```

6. Restart the application:
   ```bash
   ./start-app.sh restart
   ```

### Using Systemd (Linux only)

1. Copy the service file to the systemd directory:
   ```bash
   sudo cp mads-ui.service /etc/systemd/system/
   ```

2. Edit the service file to match your environment:
   ```bash
   sudo nano /etc/systemd/system/mads-ui.service
   ```
   
   Update the `User`, `WorkingDirectory` and `ExecStart` paths to match your setup.

3. Reload systemd:
   ```bash
   sudo systemctl daemon-reload
   ```

4. Enable and start the service:
   ```bash
   sudo systemctl enable mads-ui.service
   sudo systemctl start mads-ui.service
   ```

5. Check the status:
   ```bash
   sudo systemctl status mads-ui.service
   ```

6. View logs:
   ```bash
   sudo journalctl -u mads-ui.service
   ```

## Windows (PowerShell)

1. Run PowerShell as Administrator

2. Set execution policy to allow running the script:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. Start the application:
   ```powershell
   .\start-app.ps1 start
   ```

4. Check the status:
   ```powershell
   .\start-app.ps1 status
   ```

5. View logs:
   ```powershell
   .\start-app.ps1 logs
   ```

6. Stop the application:
   ```powershell
   .\start-app.ps1 stop
   ```

7. Restart the application:
   ```powershell
   .\start-app.ps1 restart
   ```

## Accessing the Application

Once the application is running, you can access it at:

```
http://localhost:8081
``` 