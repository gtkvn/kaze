import './bootstrap'
import '../../assets/builds/tailwind.css'

import { createRoot } from 'react-dom/client';
import { createInertiaApp } from '@inertiajs/react';

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
    resolve: (name) => resolvePageComponent(`../Pages/${name}.tsx`, import.meta.glob('../Pages/**/*.tsx')),
    setup({ el, App, props }) {
        const root = createRoot(el);

        root.render(<App {...props} />);
    },
    progress: {
        color: '#4B5563',
    },
});
