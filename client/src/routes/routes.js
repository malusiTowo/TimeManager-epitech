import DashboardLayout from '@/views/Layout/DashboardLayout.vue';
import AuthLayout from '@/views/Pages/AuthLayout.vue';

import NotFound from '@/views/NotFoundPage.vue';
import { getUserFromLocalStorage } from '../api/user';

const routes = [
  {
    path: '/',
    redirect: 'dashboard',
    component: DashboardLayout,
    children: [
      {
        path: '/dashboard',
        name: 'dashboard',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "demo" */ '../views/Dashboard.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/profile/:userId',
        name: 'profile',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Pages/UserProfile.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/chartManager/:userId',
        name: 'chart Manager',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Pages/ChartManager.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/clock/:username',
        name: 'clock',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Clock/ClockHistory.vue'),
        props: true,
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/workingtime/:userId',
        name: 'working times',
        component: () => import(/* webpackChunkName: "demo" */ '../views/WorkingTime.vue'),
        props: true,
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/adminUsers',
        name: 'admin Users',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Admin/AdminUsers.vue'),
        props: true,
        meta: {
          requiresAuth: true
        }
      },
      {
        path: '/download-apk',
        name: 'dl-apk',
        component: () => import('../views/Apk/DownloadApk.vue'),

      }
    ]
  },
  {
    path: '/',
    redirect: 'login',
    component: AuthLayout,
    children: [
      {
        path: '/login',
        name: 'login',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Pages/Login.vue'),
        meta: {
          guest: true
        }
      },
      {
        path: '/register',
        name: 'register',
        component: () => import(/* webpackChunkName: "demo" */ '../views/Pages/Register.vue'),
        meta: {
          guest: true
        }
      },
      { path: '*', component: NotFound }
    ]
  }
];

export default routes;
