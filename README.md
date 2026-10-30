
---

## 🐱the actual route

```text
   Phone ---> Iriun webcam ---> OBS Studio ---> ome.tv
```

---

## 🐱 installation and setup

### 1. save and run the Script
clone or download this directory and run it with `sudo`:

```bash
sudo ./install.sh
```

**what this script actually does:**
* installs `v4l2loopback-dkms` `` and matches your arch kernel headers.
* cleans up old configuration.
* configures `/etc/modprobe.d/` rules.

### 2. verify your drivers
run the following command to actually see if it worked:

```bash
v4l2-ctl --list-devices
```

*your terminal should list:*
* `Iriun Webcam (/dev/video0)`
* `Logitech HD Pro Webcam C920 (/dev/video1)`

---

## 🐱 how to actually use it (crucial!!!!)

to prevent applications from overriding **always launch your software in this exact order**:

1. **Iriun Webcam:** open your phone app first, then run your desktop iriun client. it will instantly bind to `/dev/video0`.
2. **Open OBS Studio:** add a new `Video Capture Device (V4L2)` source inside your scene. choose **Iriun Webcam** from the device dropdown list.
3. **Trigger the thing:** start virtual video camera because slot `0` is already chosen by iriun ( they're lovers ;) ), OBS will  route its output directly into the `/dev/video1` container.
4. **Open ometv:** refresh your browser, open ometv, click the camera icon in your address bar permissions, and change your video source to **Logitech HD Pro Webcam C920**.

---

## 🐱 troubleshooting

### virtual camera button is grayed out / won't click
ensure your OBS Studio was installed via `pacman`. if you installed OBS using flatpak, it cannot communicate with local loopback paths. if you must use flatpak then grant it permissions in your terminal:
```bash
flatpak override com.obsproject.Studio --device=all
```
