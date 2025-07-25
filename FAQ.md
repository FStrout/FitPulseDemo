#  FAQ

1. Does the SDK work offline?
Short answer, no. The SmartSpectra SDK requires the use of Presage's Physiology API to interpret the information obtained from the facial analysis to determine vitals such as pulse rate and breathing rate.

2. How do I add a real-time chart?
The SmartSpectra SDK has a built in ContinuousPlotView() function that displays real-time vitals for pulse and breathing rates in a chart like graph. You can also use the data retrieved from the metricBuffer to draw your own charts for other information other than pulse or breath rate.

3. How do I reduce CPU usage on older iPhones?
The streaming rate for acquiring facial data and retrieving the processed information from the API can be reduced to put less stress on the processor.

4. What other vitals can be acquired from the SDK?
In addition to information related to pulse and breathing, the SmartSpectra SDK allows you to acquire information related to a subjects blood pressure.
