import InputError from '@/Components/InputError'
import InputLabel from '@/Components/InputLabel'
import PrimaryButton from '@/Components/PrimaryButton'
import TextInput from '@/Components/TextInput'
import { useForm, usePage } from '@inertiajs/react'
import { Transition } from '@headlessui/react'
import { FormEventHandler } from 'react'
import { PageProps } from '@/types'
import { profile_update_path } from '@/routes'

export default function UpdateProfileInformation({ className = '' }: { className?: string }) {
  const user = usePage<PageProps>().props.auth.user

  const { data, setData, patch, errors, processing, recentlySuccessful } = useForm({
    name: user.name,
    email: user.email,
  })

  const submit: FormEventHandler = (e) => {
    e.preventDefault()

    patch(profile_update_path())
  }

  return (
    <section className={className}>
      <header>
        <h2 className="text-lg font-medium text-gray-900">Profile Information</h2>

        <p className="mt-1 text-sm text-gray-600">Update your account's profile information and email address.</p>
      </header>

      <form onSubmit={submit} className="mt-6 space-y-6">
        <div>
          <InputLabel htmlFor="name" value="Name" />

          <TextInput
            id="name"
            className="mt-1 block w-full"
            value={data.name}
            onChange={(e) => setData('name', e.target.value)}
            required
            isFocused
            autoComplete="name"
          />

          <InputError className="mt-2" message={errors.name} />
        </div>

        <div>
          <InputLabel htmlFor="email" value="Email" />

          <TextInput
            id="email"
            type="email"
            className="mt-1 block w-full"
            value={data.email}
            onChange={(e) => setData('email', e.target.value)}
            required
            autoComplete="username"
          />

          <InputError className="mt-2" message={errors.email} />
        </div>

        <div className="flex items-center gap-4">
          <PrimaryButton disabled={processing}>Save</PrimaryButton>

          <Transition
            show={recentlySuccessful}
            enter="transition ease-in-out"
            enterFrom="opacity-0"
            leave="transition ease-in-out"
            leaveTo="opacity-0"
          >
            <p className="text-sm text-gray-600">Saved.</p>
          </Transition>
        </div>
      </form>
    </section>
  )
}
