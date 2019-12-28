export default class DeviceChecker {
  constructor(userAgent) {
    this.userAgent = userAgent;
  }

  isMobile() {
    const mobileRegexp = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i;
    return mobileRegexp.test(this.userAgent);
  }
}
