import Rollbar from "@js/services/Rollbar";

export const trackEvent = ({ action, category, label }) => {
  try {
    window.gtag("event", action, {
      event_category: category,
      event_label: label,
    });
  } catch (error) {
    Rollbar.warning("window.gtag is not a function", error);
  }
};
