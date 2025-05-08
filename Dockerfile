FROM 877502627026.dkr.ecr.ap-southeast-7.amazonaws.com/miniapps-template-angular:baseimage-latest AS build

ARG BUILD_ENV=production
ARG BASE_HREF=/cp/temp/app/

WORKDIR /usr/src/app

COPY ./source/ .

RUN ng build --configuration=${BUILD_ENV} --base-href ${BASE_HREF}

FROM nginx:1.27-alpine

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/miniapps-template-angular/browser /usr/share/nginx/html
