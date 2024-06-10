import './bootstrap'
import '../../assets/builds/tailwind.css'

import { createApp, h, DefineComponent } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';

async function resolvePageComponent<T>(path: string|string[], pages: Record<string, Promise<T> | (() => Promise<T>)>): Promise<T> {
    for (const p of (Array.isArray(path) ? path : [path])) {
        const page = pages[p]

        if (typeof page === 'undefined') {
            continue
        }

        return typeof page === 'function' ? page() : page
    }

    throw new Error(`Page not found: ${path}`)
}

const appName = import.meta.env.VITE_APP_NAME || 'Rails';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`../Pages/${name}.vue`, import.meta.glob<DefineComponent>('../Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        createApp({ render: () => h(App, props) })
            .use(plugin)
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
